const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');
const http = require('http'); 
const { Server } = require('socket.io'); 

require('dotenv').config({ path: path.join(__dirname, '.env') });

const app = express();
app.use(cors());
app.use(express.json());

// --- DATABASE CONNECTION ---
const db = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'soles_1800',
    port: 3306,
    autocommit: true 
});

db.connect((err) => {
    if (err) { 
        console.error('❌ DB Connection Error:', err.message); 
        return; 
    }
    console.log('✅ Connected to MySQL Database');
});

// --- CREATE HTTP SERVER & SOCKET.IO ---
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*", 
        methods: ["GET", "POST"]
    }
});

// --- SOCKET.IO LOGIC ---
io.on('connection', (socket) => {
    console.log(`⚡ New Connection: ${socket.id}`);

    // Join a specific chat room
    socket.on('join_chat', (orderId) => {
        const room = String(orderId);
        socket.join(room);
        console.log(`👤 Socket ${socket.id} joined room: ${room}`);
    });

    // Listen for incoming messages
    socket.on('send_message', (data) => {
        const { orderId, sender, message } = data;
        
        console.log(`📩 Message Received for Room ${orderId}: "${message}" from ${sender}`);

        // 1. Save to Database
        const sql = "INSERT INTO chat_messages (order_id, sender_type, message_text) VALUES (?, ?, ?)";
        db.query(sql, [String(orderId), sender, message], (err, result) => {
            if (err) {
                console.error("❌ DATABASE INSERT ERROR:", err.message);
                return;
            }
            
            console.log(`✅ Message saved to DB (ID: ${result.insertId})`);

            const messagePayload = {
                id: result.insertId,
                orderId: String(orderId),
                sender,
                message,
                created_at: new Date()
            };
            
            // 2. Broadcast to everyone in the room (Customer + Admin)
            io.to(String(orderId)).emit('receive_message', messagePayload);
        });
    });

    socket.on('disconnect', () => {
        console.log('🔌 User Disconnected', socket.id);
    });
});

// --- CHAT API ROUTES ---

// Get specific chat history
app.get('/api/chat/:orderId', (req, res) => {
    const orderId = req.params.orderId;
    const sql = "SELECT id, order_id as orderId, sender_type as sender, message_text as message, created_at FROM chat_messages WHERE order_id = ? ORDER BY created_at ASC";
    
    db.query(sql, [orderId], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Admin Route: Get list of unique conversations
app.get('/api/admin/chats', (req, res) => {
    // This query gets the latest message from every unique sender/room
    const sql = `
        SELECT m1.order_id, m1.message_text, m1.sender_type, m1.created_at 
        FROM chat_messages m1
        WHERE m1.id IN (
            SELECT MAX(id) FROM chat_messages GROUP BY order_id
        )
        ORDER BY m1.created_at DESC
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error("❌ Error fetching admin chat list:", err.message);
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// --- AUTH ROUTES ---

app.post('/api/signup', (req, res) => {
    const { username, email, password, securityPin } = req.body;
    const cleanEmail = email ? email.toLowerCase().trim() : '';
    const sql = "INSERT INTO users (username, email, password, security_pin, role) VALUES (?, ?, ?, ?, 'user')";
    db.query(sql, [username, cleanEmail, password, securityPin], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({ message: "User registered successfully!" });
    });
});

app.post('/api/login', (req, res) => {
    const { email, password, securityPin } = req.body;
    const cleanEmail = email ? email.toLowerCase().trim() : '';
    const sql = "SELECT id, username, email, role FROM users WHERE LOWER(email) = ? AND password = ? AND security_pin = ?";
    db.query(sql, [cleanEmail, password, securityPin], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length > 0) {
            let user = results[0];
            if (!user.role || user.role.trim() === "") user.role = 'user';
            res.json({ user: user });
        } else {
            res.status(401).json({ error: "Invalid credentials" });
        }
    });
});

// --- ADMIN ORDER ROUTES ---

app.get('/api/admin/orders', (req, res) => {
    const sql = "SELECT * FROM orders ORDER BY id DESC";
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        const formattedOrders = results.map(order => {
            let items = [];
            try { items = order.items_json ? JSON.parse(order.items_json) : []; } catch (e) { items = []; }
            return { ...order, items };
        });
        res.json(formattedOrders);
    });
});

app.post('/api/admin/update-order', (req, res) => {
    const { orderId, status, courier_name, tracking_number } = req.body;
    const sql = `UPDATE orders SET status = ?, courier_name = ?, tracking_number = ? WHERE id = ?`;
    db.query(sql, [status, courier_name, tracking_number, orderId], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: "Order updated successfully!" });
    });
});

// --- CUSTOMER TRACKING UPDATES ---

app.post('/api/orders/:id/driver-link', (req, res) => {
    const orderId = req.params.id;
    const { driver_link, rider_name, rider_contact } = req.body;

    const sql = "UPDATE orders SET driver_link = ?, rider_name = ?, rider_contact = ? WHERE id = ?";
    
    db.query(sql, [driver_link, rider_name, rider_contact, orderId], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ error: "Order not found" });
        res.json({ message: "Rider details shared with Admin!" });
    });
});

// --- ORDER ROUTES ---

app.post('/api/orders', (req, res) => {
    const data = req.body;
    const orderObj = {
        email: (data.email || 'guest@unknown.com').toLowerCase().trim(),
        first_name: data.firstName || data.first_name || 'N/A',
        last_name: data.lastName || data.last_name || 'N/A',
        phone: data.phone || 'N/A',
        address: data.address || 'N/A',
        city: data.city || 'N/A',
        landmark: data.landmark || '',
        pickup_date: data.pickupDate || data.pickup_date || '',
        shipping_method: data.shippingType || data.shipping_method || 'Standard',
        payment_method: data.payment_method || data.paymentMethod || 'Cash',
        total: parseFloat(String(data.finalTotal || data.total).replace(/[^0-9.]/g, '')) || 0,
        items_json: JSON.stringify(data.items || [])
    };

    const sql = `INSERT INTO orders 
        (email, first_name, last_name, phone, address, city, landmark, pickup_date, shipping_method, total, payment_method, items_json, status) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Preparing your order')`;

    db.query(sql, [
        orderObj.email, orderObj.first_name, orderObj.last_name, orderObj.phone,
        orderObj.address, orderObj.city, orderObj.landmark, orderObj.pickup_date,
        orderObj.shipping_method, orderObj.total, orderObj.payment_method, orderObj.items_json
    ], (err, result) => {
        if (err) return res.status(500).json({ error: "Database error" });
        res.status(200).json({ message: "Success", orderId: result.insertId });
    });
});

app.get('/api/user-orders/:email', (req, res) => {
    const searchEmail = req.params.email ? req.params.email.toLowerCase().trim() : '';
    const sql = "SELECT * FROM orders WHERE LOWER(email) = ? ORDER BY id DESC";
    db.query(sql, [searchEmail], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        const formattedOrders = results.map(order => {
            let items = [];
            try { items = order.items_json ? JSON.parse(order.items_json) : []; } catch (e) { items = []; }
            return { ...order, items, total: parseFloat(order.total) };
        });
        res.json(formattedOrders);
    });
});

app.get('/api/orders/:id', (req, res) => {
    db.query("SELECT * FROM orders WHERE id = ?", [req.params.id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length > 0) {
            const order = results[0];
            try { order.items = order.items_json ? JSON.parse(order.items_json) : []; } catch (e) { order.items = []; }
            res.json(order);
        } else {
            res.status(404).json({ error: "Order not found" });
        }
    });
});

const PORT = 3001; 
server.listen(PORT, () => {
    console.log(`\n🔥 BACKEND RUNNING ON http://localhost:${PORT}`);
    console.log(`⚡ SOCKET.IO ENABLED\n`);
});