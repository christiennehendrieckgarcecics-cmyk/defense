# 1800 Soles - Sneaker E-Commerce & Support

A full-stack e-commerce platform for sneakers featuring real-time admin-customer chat, order tracking, and a dynamic shopping cart.

## 🚀 Features
- **Real-time Support:** Socket.io powered chat between customers and admin.
- **Order Management:** Customers can place orders; admins can update status and tracking.
- **Authentication:** Secure login with Email, Password, and Security PIN.
- **Persistent Chat:** History is saved in MySQL for both parties.

## 🛠️ Tech Stack
- **Frontend:** Vue.js 3 (Composition API), Tailwind CSS
- **Backend:** Node.js, Express
- **Real-time:** Socket.io
- **Database:** MySQL

## 📦 Installation
1. **Clone the repo:**
   ```bash
   git clone <your-repo-link>

## 📦 Project Structure

```text
├── backend/            # Express server & API routes
│   ├── server.js       # Main entry point
│   └── .env            # Database credentials (ignored)
├── frontend/           # Vue.js application
│   ├── src/
│   │   ├── views/      # Page components (Tracking, Order, Login)
│   │   └── App.vue     # Main application shell
└── README.md

##
.env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=soles_1800

##
cd backend
npm install
node server.js
##
cd frontend
npm install
npm run dev
##

