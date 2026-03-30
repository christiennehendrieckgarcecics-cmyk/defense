const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');
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

// --- ADMIN ROUTES ---

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

// FIX: Updated to ensure all rider fields are captured
app.post('/api/orders/:id/driver-link', (req, res) => {
    const orderId = req.params.id;
    const { driver_link, rider_name, rider_contact } = req.body;

    // Log the incoming data to the terminal for debugging
    console.log(`\n--- Incoming Rider Details for Order #${orderId} ---`);
    console.log(`Link: ${driver_link}`);
    console.log(`Name: ${rider_name}`);
    console.log(`Phone: ${rider_contact}\n`);

    const sql = "UPDATE orders SET driver_link = ?, rider_name = ?, rider_contact = ? WHERE id = ?";
    
    db.query(sql, [driver_link, rider_name, rider_contact, orderId], (err, result) => {
        if (err) {
            console.error("❌ SQL Error:", err.message);
            return res.status(500).json({ error: err.message });
        }
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: "Order not found" });
        }

        console.log("✅ Database updated successfully");
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
app.listen(PORT, () => {
    console.log(`\n🔥 BACKEND RUNNING ON http://localhost:${PORT}\n`);
});