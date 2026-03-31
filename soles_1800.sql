-- Database: soles_1800
CREATE DATABASE IF NOT EXISTS soles_1800;
USE soles_1800;

-- Table for user accounts
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    security_pin VARCHAR(10) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for orders
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    landmark VARCHAR(255),
    pickup_date VARCHAR(50),
    shipping_method VARCHAR(50),
    total DECIMAL(10, 2),
    payment_method VARCHAR(50),
    items_json JSON,
    status VARCHAR(50) DEFAULT 'Preparing your order',
    driver_link VARCHAR(255),
    rider_name VARCHAR(100),
    rider_contact VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for chat messages
CREATE TABLE IF NOT EXISTS chat_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(255) NOT NULL,
    sender_type ENUM('customer', 'admin') NOT NULL,
    message_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);