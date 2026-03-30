-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2026 at 03:32 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soles_1800`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `pickup_date` varchar(50) DEFAULT NULL,
  `shipping_method` varchar(100) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `items_json` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'Preparing your order',
  `courier_name` varchar(100) DEFAULT '',
  `tracking_number` varchar(100) DEFAULT '',
  `driver_link` text DEFAULT NULL,
  `rider_name` varchar(255) DEFAULT NULL,
  `rider_contact` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `email`, `first_name`, `last_name`, `phone`, `address`, `city`, `landmark`, `pickup_date`, `shipping_method`, `total`, `payment_method`, `items_json`, `created_at`, `status`, `courier_name`, `tracking_number`, `driver_link`, `rider_name`, `rider_contact`) VALUES
(1, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'hendrieckg@gmail.com', 'San Pedro city', NULL, '12/22/2203', 'Standard', 7000.00, 'Cash', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 03:49:09', 'Preparing your order', '', '', NULL, NULL, NULL),
(2, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 14008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 03:51:51', 'Preparing your order', '', '', NULL, NULL, NULL),
(3, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:03:06', 'Preparing your order', '', '', NULL, NULL, NULL),
(4, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:04:50', 'Preparing your order', '', '', NULL, NULL, NULL),
(5, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:08:09', 'Preparing your order', '', '', NULL, NULL, NULL),
(6, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:09:22', 'Preparing your order', '', '', NULL, NULL, NULL),
(7, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:11:40', 'Preparing your order', '', '', NULL, NULL, NULL),
(8, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:18:00', 'Preparing your order', '', '', NULL, NULL, NULL),
(9, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:19:45', 'Preparing your order', '', '', NULL, NULL, NULL),
(10, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:21:58', 'Preparing your order', '', '', NULL, NULL, NULL),
(11, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 54508.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Samba OG \\\"Cloud White\\\"\",\"price\":\"3,500.00\",\"selectedSize\":\"7M/25.4CM\"},{\"name\":\"NMD R1 \\\"OG White\\\"\",\"price\":\"3,000.00\",\"selectedSize\":\"12M/28.6CM\"},{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Samba OG \\\"Cloud White\\\"\",\"price\":\"3,500.00\",\"selectedSize\":\"7M/25.4CM\"},{\"name\":\"AUTHENTIC 44 DX ANAHEIM\",\"price\":\"2,500.00\",\"selectedSize\":\"11M/28CM\"}]', '2026-03-27 04:25:32', 'Preparing your order', '', '', NULL, NULL, NULL),
(12, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:25:58', 'Preparing your order', '', '', NULL, NULL, NULL),
(13, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 3508.50, 'E-Wallet', '[{\"name\":\"Samba OG \\\"Cloud White\\\"\",\"price\":\"3,500.00\",\"selectedSize\":\"7M/25.4CM\"}]', '2026-03-27 04:26:31', 'Preparing your order', '', '', NULL, NULL, NULL),
(14, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 3508.50, 'E-Wallet', '[{\"name\":\"Samba OG \\\"Cloud White\\\"\",\"price\":\"3,500.00\",\"selectedSize\":\"7M/25.4CM\"}]', '2026-03-27 04:30:04', 'Preparing your order', '', '', NULL, NULL, NULL),
(15, 'hendrieckgg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:31:09', 'Preparing your order', '', '', NULL, NULL, NULL),
(16, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 3508.50, 'E-Wallet', '[{\"name\":\"Samba OG \\\"Cloud White\\\"\",\"price\":\"3,500.00\",\"selectedSize\":\"7M/25.4CM\"}]', '2026-03-27 04:32:48', 'Preparing your order', '', '', NULL, NULL, NULL),
(17, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:33:42', 'Preparing your order', '', '', NULL, NULL, NULL),
(18, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 14008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"},{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 04:51:03', 'Preparing your order', '', '', NULL, NULL, NULL),
(19, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 06:41:48', 'Preparing your order', '', '', NULL, NULL, NULL),
(20, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LALAMOVE', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 06:46:18', 'Preparing your order', '', '', NULL, NULL, NULL),
(21, 'hendrieckg@gmail.com', 'Sumayah', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-27 07:55:21', 'Preparing your order', '', '', NULL, NULL, NULL),
(22, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 08:57:10', 'Preparing your order', '', '', NULL, NULL, NULL),
(23, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:01:21', 'Preparing your order', '', '', NULL, NULL, NULL),
(24, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:02:28', 'Preparing your order', '', '', NULL, NULL, NULL),
(25, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:07:09', 'Preparing your order', '', '', NULL, NULL, NULL),
(26, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:07:35', 'Preparing your order', '', '', NULL, NULL, NULL),
(27, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:16:58', 'Preparing your order', '', '', NULL, NULL, NULL),
(28, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:17:55', 'Preparing your order', '', '', NULL, NULL, NULL),
(29, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:27:08', 'Preparing your order', '', '', NULL, NULL, NULL),
(30, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:29:32', 'Preparing your order', '', '', NULL, NULL, NULL),
(31, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:34:15', 'Preparing your order', '', '', NULL, NULL, NULL),
(32, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:36:55', 'Preparing your order', '', '', NULL, NULL, NULL),
(33, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 09:38:49', 'Preparing your order', '', '', NULL, NULL, NULL),
(34, 'hendrieck@gmail.com', 'hendrieck', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 11:12:19', 'Preparing your order', '', '', NULL, NULL, NULL),
(35, 'jonagarce@gmail.com', 'jonagarce', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 11:14:04', 'Preparing your order', '', '', NULL, NULL, NULL),
(36, 'jonagarce@gmail.com', 'jonagarce', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 11:20:16', 'Preparing your order', '', '', NULL, NULL, NULL),
(37, 'wolfiehenry@gmail.com', 'wolfiehenry', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 11:39:03', 'Preparing your order', '', '', NULL, NULL, NULL),
(38, 'wolfiehenry@gmail.com', 'wolfiehenry', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LALAMOVE', 7008.50, 'E-Wallet', '[{\"name\":\"Yeezy 350 V2 \\\"Cloud White\\\"\",\"price\":\"7,000.00\",\"selectedSize\":\"5M/24.5CM\"}]', '2026-03-30 11:43:58', 'In Transit', '', '', NULL, NULL, NULL),
(39, 'redharex@gmail.com', 'redharex', 'Alsanea', '09690710651', 'Block 10 Lot & Celine Dion Street Mercedes 5 San Pedro , Laguna', 'San Pedro city', 'jhwdjkjwed', '12/22/2203', 'LOCAL PICK-UP', 17008.50, 'E-Wallet', '[{\"name\":\"Jordan 1 Low \\\"Shattered Blackboard\\\" 2019\",\"price\":\"4,000.00\",\"selectedSize\":\"9M/23 CM\"},{\"name\":\"Jordan 11 \\\"Space Jam\\\" 2016\",\"price\":\"13,000.00\",\"selectedSize\":\"12M/28.6CM\"}]', '2026-03-30 12:37:42', 'Preparing your order', '', '', 'website.com', 'cindy', '0957362837');

-- --------------------------------------------------------

--
-- Table structure for table `sneakers`
--

CREATE TABLE `sneakers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `size1` varchar(20) DEFAULT NULL,
  `size2` varchar(20) DEFAULT NULL,
  `size3` varchar(20) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sneakers`
--

INSERT INTO `sneakers` (`id`, `name`, `brand`, `price`, `size1`, `size2`, `size3`, `fileName`) VALUES
(1, 'Jordan 1 Low \"Shattered Blackboard\"', 'nike', 4000.00, '9M', '10M', NULL, 'shattered-backboard.png'),
(2, 'Yeezy 350 V2 \"Cloud White\"', 'adidas', 7000.00, '5M', '4F', NULL, 'yeezy-cloud.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `security_pin` varchar(10) NOT NULL,
  `role` varchar(10) DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `security_pin`, `role`) VALUES
(1, 'henryy', 'henryy@gmail.com', '123', '2026-03-26 16:58:24', '', 'user'),
(2, 'hendrieck', 'hendrieck@gmail.com', '12345', '2026-03-26 17:05:36', '', 'user'),
(3, 'jana', 'jana@gmail.com', '123456', '2026-03-26 17:28:06', '', 'user'),
(4, 'sophiareyes', 'sophiareyes@gmail.com', '1234567', '2026-03-26 17:30:15', '', 'user'),
(5, 'henryy', 'henryyy@gmail.com', 'qwer', '2026-03-27 03:29:21', '', 'user'),
(6, 'ynigo', 'ynigo@gmail.com', 'zxcv', '2026-03-27 03:39:20', '', 'user'),
(7, 'arianagrande', 'ariana@gmail.com', 'grande', '2026-03-27 03:50:56', '', 'user'),
(8, 'billie', 'billieeilish@gmail.com', '098', '2026-03-27 04:04:23', '', 'user'),
(9, 'jakegyllen', 'jakegyllen@gmail.com', 'tyu', '2026-03-27 04:09:02', '', 'user'),
(10, 'brunomars', 'bruno@gmail.com', 'mars', '2026-03-27 04:30:37', '', 'user'),
(11, 'imelda', 'imeldamarollano@gmail.com', '123', '2026-03-27 04:50:10', '', 'user'),
(12, 'henryg', 'henryg@gmail.com', '123', '2026-03-27 06:38:56', '', 'user'),
(13, 'jonagarce', 'jonagarce@gmail.com', 'jona', '2026-03-30 11:13:33', '', 'user'),
(14, 'hendrieckgarce', 'hendrieckgarce@gmail.com', '12345', '2026-03-30 11:31:15', '', 'user'),
(15, 'wolfiehenry', 'wolfiehenry@gmail.com', '12345', '2026-03-30 11:36:22', '1234', 'user'),
(16, 'cedric', 'cedric@gmail.com', '12345', '2026-03-30 12:00:53', '1234', 'admin'),
(17, 'redharex', 'redharex@gmail.com', '12345678', '2026-03-30 12:36:53', '1234', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sneakers`
--
ALTER TABLE `sneakers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `sneakers`
--
ALTER TABLE `sneakers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
