const express = require('express');
const cors = require('cors');
const path = require('path');
const http = require('http'); 
const { Server } = require('socket.io'); 
const { createClient } = require('@supabase/supabase-js');

require('dotenv').config({ path: path.join(__dirname, '.env') });

const app = express();
app.use(cors());
app.use(express.json());

// --- SUPABASE CONNECTION ---
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('❌ Missing SUPABASE_URL or SUPABASE_KEY in .env file!');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);
console.log('✅ Connected to Supabase Database');

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
    socket.on('send_message', async (data) => {
        const { orderId, sender, message } = data;
        
        console.log(`📩 Message Received for Room ${orderId}: "${message}" from ${sender}`);

        // 1. Save to Supabase
        const { data: insertedData, error } = await supabase
            .from('chat_messages')
            .insert([{ 
                order_id: String(orderId), 
                sender_type: sender, 
                message_text: message 
            }])
            .select();

        if (error) {
            console.error("❌ SUPABASE INSERT ERROR:", error.message);
            return;
        }

        const newMsg = insertedData[0];
        console.log(`✅ Message saved to Supabase (ID: ${newMsg.id})`);

        const messagePayload = {
            id: newMsg.id,
            orderId: newMsg.order_id, // Map for frontend
            sender: newMsg.sender_type, // Map for frontend
            message: newMsg.message_text, // Map for frontend
            created_at: newMsg.created_at
        };
        
        // 2. Broadcast to everyone in the room (Customer + Admin)
        io.to(String(orderId)).emit('receive_message', messagePayload);
    });

    socket.on('disconnect', () => {
        console.log('🔌 User Disconnected', socket.id);
    });
});

// --- CHAT API ROUTES ---

// Get specific chat history
app.get('/api/chat/:orderId', async (req, res) => {
    const orderId = req.params.orderId;
    
    const { data, error } = await supabase
        .from('chat_messages')
        .select('id, order_id, sender_type, message_text, created_at')
        .eq('order_id', orderId)
        .order('created_at', { ascending: true });

    if (error) return res.status(500).json({ error: error.message });

    // Map the database columns to what your frontend expects
    const formattedChats = data.map(chat => ({
        id: chat.id,
        orderId: chat.order_id,
        sender: chat.sender_type,
        message: chat.message_text,
        created_at: chat.created_at
    }));

    res.json(formattedChats);
});

// Admin Route: Get list of unique conversations
app.get('/api/admin/chats', async (req, res) => {
    // Fetch all chats ordered by newest first
    const { data, error } = await supabase
        .from('chat_messages')
        .select('id, order_id, sender_type, message_text, created_at')
        .order('created_at', { ascending: false });

    if (error) {
        console.error("❌ Error fetching admin chat list:", error.message);
        return res.status(500).json({ error: error.message });
    }

    // Filter to keep only the latest message for each unique order_id
    const uniqueChats = [];
    const seenOrders = new Set();
    
    for (const msg of data) {
        if (!seenOrders.has(msg.order_id)) {
            seenOrders.add(msg.order_id);
            uniqueChats.push(msg);
        }
    }

    res.json(uniqueChats);
});

// --- AUTH ROUTES ---

app.post('/api/signup', async (req, res) => {
    const { username, email, password, securityPin } = req.body;
    const cleanEmail = email ? email.toLowerCase().trim() : '';
    
    const { error } = await supabase
        .from('users')
        .insert([{ 
            username, 
            email: cleanEmail, 
            password, 
            security_pin: securityPin, 
            role: 'user' 
        }]);

    if (error) return res.status(500).json({ error: error.message });
    res.status(201).json({ message: "User registered successfully!" });
});

app.post('/api/login', async (req, res) => {
    const { email, password, securityPin } = req.body;
    const cleanEmail = email ? email.toLowerCase().trim() : '';

    const { data, error } = await supabase
        .from('users')
        .select('id, username, email, role')
        .ilike('email', cleanEmail) // Case-insensitive exact match
        .eq('password', password)
        .eq('security_pin', securityPin);

    if (error) return res.status(500).json({ error: error.message });

    if (data && data.length > 0) {
        let user = data[0];
        if (!user.role || user.role.trim() === "") user.role = 'user';
        res.json({ user: user });
    } else {
        res.status(401).json({ error: "Invalid credentials" });
    }
});

// --- ADMIN ORDER ROUTES ---

app.get('/api/admin/orders', async (req, res) => {
    const { data, error } = await supabase
        .from('orders')
        .select('*')
        .order('id', { ascending: false });

    if (error) return res.status(500).json({ error: error.message });

    const formattedOrders = data.map(order => {
        let items = [];
        try { items = order.items_json ? JSON.parse(order.items_json) : []; } catch (e) { items = []; }
        return { ...order, items };
    });
    
    res.json(formattedOrders);
});

app.post('/api/admin/update-order', async (req, res) => {
    const { orderId, status, courier_name, tracking_number } = req.body;
    
    const { error } = await supabase
        .from('orders')
        .update({ status, courier_name, tracking_number })
        .eq('id', orderId);

    if (error) return res.status(500).json({ error: error.message });
    res.json({ message: "Order updated successfully!" });
});

// --- CUSTOMER TRACKING UPDATES ---

app.post('/api/orders/:id/driver-link', async (req, res) => {
    const orderId = req.params.id;
    const { driver_link, rider_name, rider_contact } = req.body;

    const { data, error } = await supabase
        .from('orders')
        .update({ driver_link, rider_name, rider_contact })
        .eq('id', orderId)
        .select();

    if (error) return res.status(500).json({ error: error.message });
    if (!data || data.length === 0) return res.status(404).json({ error: "Order not found" });
    
    res.json({ message: "Rider details shared with Admin!" });
});

// --- ORDER ROUTES ---

app.post('/api/orders', async (req, res) => {
    const data = req.body;
    
    const newOrder = {
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
        items_json: JSON.stringify(data.items || []),
        status: 'Preparing your order'
    };

    const { data: insertedOrder, error } = await supabase
        .from('orders')
        .insert([newOrder])
        .select('id');

    if (error) return res.status(500).json({ error: "Database error", details: error.message });
    res.status(200).json({ message: "Success", orderId: insertedOrder[0].id });
});

app.get('/api/user-orders/:email', async (req, res) => {
    const searchEmail = req.params.email ? req.params.email.toLowerCase().trim() : '';
    
    const { data, error } = await supabase
        .from('orders')
        .select('*')
        .ilike('email', searchEmail)
        .order('id', { ascending: false });

    if (error) return res.status(500).json({ error: error.message });

    const formattedOrders = data.map(order => {
        let items = [];
        try { items = order.items_json ? JSON.parse(order.items_json) : []; } catch (e) { items = []; }
        return { ...order, items, total: parseFloat(order.total) };
    });
    res.json(formattedOrders);
});

app.get('/api/orders/:id', async (req, res) => {
    const { data, error } = await supabase
        .from('orders')
        .select('*')
        .eq('id', req.params.id)
        .single(); // Forces returning a single object instead of an array

    // Supabase returns PGRST116 when no rows are found with .single()
    if (error && error.code !== 'PGRST116') return res.status(500).json({ error: error.message });
    
    if (data) {
        const order = data;
        try { order.items = order.items_json ? JSON.parse(order.items_json) : []; } catch (e) { order.items = []; }
        res.json(order);
    } else {
        res.status(404).json({ error: "Order not found" });
    }
});

const PORT = process.env.PORT || 3001; 
server.listen(PORT, () => {
    console.log(`\n🔥 BACKEND RUNNING ON http://localhost:${PORT}`);
    console.log(`⚡ SOCKET.IO ENABLED\n`);
});