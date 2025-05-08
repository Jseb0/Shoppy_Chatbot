-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 13, 2024 at 11:18 AM
-- Server version: 8.0.35
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ShoppyDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `appointment_date` datetime NOT NULL,
  `status` enum('Scheduled','Cancelled','Completed') DEFAULT 'Scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_rules`
--

CREATE TABLE `chatbot_rules` (
  `rule_id` int NOT NULL,
  `keyword` varchar(100) NOT NULL,
  `response` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `chatbot_rules`
--

INSERT INTO `chatbot_rules` (`rule_id`, `keyword`, `response`) VALUES
(1, 'hello', 'Hello! How can I assist you today?'),
(2, 'order status', 'To check your order status, please provide your order ID.'),
(3, 'return', 'Our return policy allows returns within 30 days of purchase.'),
(4, 'refund', 'Refunds are processed within 7 business days after approval.'),
(5, 'shipping', 'We offer free shipping on orders over £50.'),
(6, 'cancel order', 'Orders can be cancelled within 24 hours of placing them.'),
(7, 'track order', 'You can track your order using the tracking link sent to your email.'),
(8, 'exchange', 'We allow exchanges within 30 days for unworn items.'),
(9, 'promo code', 'Use WELCOME10 for 10% off your first order.'),
(10, 'payment methods', 'We accept Visa, MasterCard, PayPal, and more.'),
(11, 'membership', 'Join our membership program for exclusive discounts and offers.'),
(12, 'store locations', 'Visit our website to find the store closest to you.'),
(13, 'opening hours', 'We are open Monday to Friday, 9 AM to 9 PM.'),
(14, 'contact support', 'You can reach us at support@example.com or call 123-456-7890.'),
(15, 'order delay', 'We apologize for the delay. Please provide your order ID for assistance.'),
(16, 'product availability', 'Check the product page for the most accurate stock information.'),
(17, 'order confirmation', 'An order confirmation email is sent to your registered email after purchase.'),
(18, 'gift card', 'We offer gift cards starting from £10. Check our Gift Cards section for more details.'),
(19, 'loyalty program', 'Earn points on every purchase and redeem them for discounts.'),
(20, 'custom orders', 'Currently, we do not accept custom orders, but we value your suggestions.'),
(21, 'bulk orders', 'For bulk orders, please contact our sales team at sales@example.com.'),
(22, 'delivery time', 'Standard delivery takes 3-5 business days. Expedited options are available at checkout.'),
(23, 'international shipping', 'We ship internationally. Additional charges and delivery times apply.'),
(24, 'same-day delivery', 'Same-day delivery is available in select locations. Check availability at checkout.'),
(25, 'wishlist', 'Use the wishlist feature to save your favorite items for later.'),
(26, 'newsletter', 'Subscribe to our newsletter to stay updated on the latest products and offers.'),
(27, 'out of stock', 'You can sign up for back-in-stock notifications on the product page.'),
(28, 'security', 'We use industry-standard security to protect your personal information.'),
(29, 'password reset', 'Click on \"Forgot Password\" on the login page to reset your password.'),
(30, 'size guide', 'Check our size guide on the product page for accurate sizing information.'),
(31, 'material information', 'Details about the material and care instructions are available on the product page.'),
(32, 'returns process', 'To return an item, go to your orders section and select the item to return.'),
(33, 'delivery tracking', 'Use the tracking link sent to your email to follow your delivery.'),
(34, 'discount policy', 'Discount codes cannot be combined with other promotions unless specified.'),
(35, 'environmental policy', 'We are committed to sustainability and use eco-friendly materials where possible.'),
(36, 'cancelled order', 'If your order was cancelled, check your email for further details.'),
(37, 'exchange request', 'Submit an exchange request via your account\'s orders section.'),
(38, 'order assistance', 'Provide your order ID, and we will assist you with any issues.'),
(39, 'payment failed', 'If your payment failed, try again or contact your bank.'),
(40, 'product reviews', 'Share your feedback by leaving a review on the product page.'),
(41, 'seasonal offers', 'Check our website for special discounts during seasonal sales.'),
(42, 'login issues', 'Clear your browser cache or reset your password to resolve login issues.'),
(43, 'data privacy', 'We value your privacy. Read our privacy policy on our website.'),
(44, 'delivery issue', 'For delivery issues, contact us with your order ID.'),
(45, 'gift wrapping', 'Gift wrapping is available for an additional charge during checkout.'),
(46, 'order history', 'View your order history in the \"My Orders\" section of your account.'),
(47, 'new arrivals', 'Check the \"New Arrivals\" section on our homepage for the latest products.'),
(48, 'free returns', 'Enjoy free returns within 30 days of purchase.'),
(49, 'credit card charges', 'Charges may appear as \"Shoppy Ltd\" on your credit card statement.');

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `conversation_id` int NOT NULL,
  `user_id` int NOT NULL,
  `user_message` text NOT NULL,
  `bot_message` text NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`conversation_id`, `user_id`, `user_message`, `bot_message`, `timestamp`) VALUES
(1, 1, 'hello', 'Hello! How can I assist you today?', '2024-12-13 11:01:30'),
(2, 1, 'order', 'I\'m sorry, I didn\'t understand that. Can you rephrase?', '2024-12-13 11:01:34'),
(3, 1, 'return', 'Our return policy allows returns within 30 days of purchase.', '2024-12-13 11:01:37'),
(4, 1, 'shipping', 'We offer free shipping on orders over £50.', '2024-12-13 11:01:40'),
(5, 1, 'help', 'I\'m sorry, I didn\'t understand that. Can you rephrase?', '2024-12-13 11:01:42'),
(6, 1, 'bye', 'I\'m sorry, I didn\'t understand that. Can you rephrase?', '2024-12-13 11:01:45');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  `comments` text,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `user_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `product_name`, `amount`, `status`) VALUES
(1, 1, '2023-12-10 15:30:00', 'T-Shirt', 19.99, 'Delivered'),
(2, 2, '2023-12-11 16:00:00', 'Jeans', 39.99, 'Shipped'),
(3, 3, '2023-12-12 17:00:00', 'Jacket', 59.99, 'Pending'),
(4, 4, '2023-12-13 18:00:00', 'Hoodie', 29.99, 'Cancelled'),
(5, 5, '2023-12-14 19:00:00', 'Sweater', 24.99, 'Delivered'),
(6, 6, '2023-12-15 14:00:00', 'Skirt', 34.99, 'Pending'),
(7, 7, '2023-12-16 12:00:00', 'Shorts', 19.99, 'Shipped'),
(8, 8, '2023-12-17 11:00:00', 'Scarf', 14.99, 'Delivered'),
(9, 9, '2023-12-18 13:00:00', 'Gloves', 12.99, 'Pending'),
(10, 10, '2023-12-19 10:00:00', 'Hat', 14.99, 'Shipped'),
(11, 11, '2023-12-20 09:00:00', 'Socks', 9.99, 'Delivered'),
(12, 12, '2023-12-21 08:00:00', 'Trousers', 39.99, 'Pending'),
(13, 13, '2023-12-22 07:00:00', 'Blouse', 29.99, 'Cancelled'),
(14, 14, '2023-12-23 06:00:00', 'Shirt', 24.99, 'Shipped'),
(15, 15, '2023-12-24 05:00:00', 'Dress', 59.99, 'Delivered'),
(16, 16, '2023-12-25 04:00:00', 'Coat', 89.99, 'Pending'),
(17, 17, '2023-12-26 03:00:00', 'Cardigan', 44.99, 'Shipped'),
(18, 18, '2023-12-27 02:00:00', 'Jumpsuit', 49.99, 'Delivered'),
(19, 19, '2023-12-28 01:00:00', 'Leggings', 34.99, 'Cancelled'),
(20, 20, '2023-12-29 00:00:00', 'Vest', 19.99, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `username`, `password`, `phone_number`, `email`, `created_at`) VALUES
(1, 'John', 'Smith', 'johnsmith', 'password123', '07400123456', 'john.smith@gmail.com', '2024-12-13 10:42:36'),
(2, 'Emily', 'Jones', 'emilyjones', 'password123', '07400987654', 'emily.jones@yahoo.com', '2024-12-13 10:42:36'),
(3, 'James', 'Taylor', 'jamestaylor', 'password123', '07400567890', 'james.taylor@outlook.com', '2024-12-13 10:42:36'),
(4, 'Sophia', 'Brown', 'sophiabrown', 'password123', '07400111222', 'sophia.brown@gmail.com', '2024-12-13 10:42:36'),
(5, 'Daniel', 'Wilson', 'danielwilson', 'password123', '07400222333', 'daniel.wilson@icloud.com', '2024-12-13 10:42:36'),
(6, 'Chloe', 'Moore', 'chloemoore', 'password123', '07400133444', 'chloe.moore@gmail.com', '2024-12-13 10:42:36'),
(7, 'Liam', 'Evans', 'liamevans', 'password123', '07400334455', 'liam.evans@outlook.com', '2024-12-13 10:42:36'),
(8, 'Olivia', 'White', 'oliviawhite', 'password123', '07400445566', 'olivia.white@yahoo.com', '2024-12-13 10:42:36'),
(9, 'Noah', 'Clark', 'noahclark', 'password123', '07400556677', 'noah.clark@gmail.com', '2024-12-13 10:42:36'),
(10, 'Isabella', 'Hall', 'isabellahall', 'password123', '07400667788', 'isabella.hall@icloud.com', '2024-12-13 10:42:36'),
(11, 'Jacob', 'Young', 'jacobyoung', 'password123', '07400778899', 'jacob.young@gmail.com', '2024-12-13 10:42:36'),
(12, 'Mia', 'Turner', 'miaturner', 'password123', '07400889900', 'mia.turner@yahoo.com', '2024-12-13 10:42:36'),
(13, 'Ethan', 'Harris', 'ethanharris', 'password123', '07400990011', 'ethan.harris@outlook.com', '2024-12-13 10:42:36'),
(14, 'Ava', 'Lewis', 'avalewis', 'password123', '07401001122', 'ava.lewis@gmail.com', '2024-12-13 10:42:36'),
(15, 'Logan', 'Walker', 'loganwalker', 'password123', '07401112233', 'logan.walker@icloud.com', '2024-12-13 10:42:36'),
(16, 'Ella', 'Robinson', 'ellarobinson', 'password123', '07401223344', 'ella.robinson@gmail.com', '2024-12-13 10:42:36'),
(17, 'Mason', 'Scott', 'masonscott', 'password123', '07401334455', 'mason.scott@yahoo.com', '2024-12-13 10:42:36'),
(18, 'Charlotte', 'Green', 'charlottegreen', 'password123', '07401445566', 'charlotte.green@outlook.com', '2024-12-13 10:42:36'),
(19, 'Oliver', 'Adams', 'oliveradams', 'password123', '07401556677', 'oliver.adams@gmail.com', '2024-12-13 10:42:36'),
(20, 'Amelia', 'Bell', 'ameliabell', 'password123', '07401667788', 'amelia.bell@icloud.com', '2024-12-13 10:42:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chatbot_rules`
--
ALTER TABLE `chatbot_rules`
  ADD PRIMARY KEY (`rule_id`),
  ADD UNIQUE KEY `keyword` (`keyword`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`conversation_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chatbot_rules`
--
ALTER TABLE `chatbot_rules`
  MODIFY `rule_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `conversation_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `conversations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
