-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2025 at 05:06 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `irispharma`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `inventory_summary` ()   BEGIN
  SELECT 
    category,
    COUNT(*) AS total_products,
    SUM(quantity_in_stock) AS total_units
  FROM products
  GROUP BY category;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `low_stock_alert` (IN `threshold` INT)   BEGIN
  SELECT product_name, quantity_in_stock
  FROM products
  WHERE quantity_in_stock < threshold;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nearing_expiry` (IN `days_ahead` INT)   BEGIN
  SELECT product_name, expiry_date
  FROM products
  WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL days_ahead DAY);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `quantity_in_stock` int(11) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `batch_number` varchar(50) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category`, `description`, `quantity_in_stock`, `expiry_date`, `unit_price`, `batch_number`, `supplier_id`) VALUES
(7, 'Chamomile Tea', 'Herbal', 'Promotes relaxation and supports sleep.', 25, '2026-03-15', 6.50, 'CHT-2025-01', 1),
(8, 'Echinacea Drops', 'Supplement', 'Boosts the immune system during seasonal changes.', 18, '2025-12-01', 12.99, 'ECD-2024-02', 2),
(9, 'Lavender Balm', 'Homeopathic', 'Used for calming skin and promoting relaxation.', 12, '2026-01-01', 7.20, 'LVB-2025-03', 4),
(10, 'St. John’s Wort Oil', 'Herbal', 'Traditionally used for mood support.', 10, '2025-11-10', 9.50, 'SJW-2025-04', 6),
(11, 'Milk Thistle Capsules', 'Supplement', 'Supports liver function and detox.', 20, '2026-02-01', 14.25, 'MTC-2026-05', 2),
(12, 'Valerian Root Tincture', 'Herbal', 'Natural aid for sleep and anxiety.', 7, '2025-12-31', 11.99, 'VRT-2025-06', 1),
(13, 'Propolis Spray', 'Homeopathic', 'Supports oral health and soothes sore throats.', 15, '2026-01-07', 8.99, 'PPS-2024-07', 3),
(14, 'Aloe Vera Gel', 'Herbal', 'Cools and moisturizes skin.', 22, '2026-03-31', 6.75, 'AVG-2025-08', 1),
(15, 'Calendula Cream', 'Homeopathic', 'Used for minor wounds and skin irritation.', 9, '2025-10-31', 5.95, 'CLC-2025-09', 5),
(16, 'Moringa Powder', 'Supplement', 'Nutrient-dense powder for energy and immunity.', 30, '2026-03-20', 10.80, 'MGP-2026-10', 1),
(17, 'Turmeric Capsules', 'Supplement', 'Anti-inflammatory and antioxidant properties.', 17, '2026-01-15', 13.50, 'TRC-2026-11', 2),
(18, 'Ginger Tea', 'Herbal', 'Helps with digestion and nausea relief.', 28, '2026-09-17', 4.99, 'GNT-2025-12', 6),
(19, 'Evening Primrose Oil', 'Herbal', 'Hormonal balance and skin support.', 11, '2025-12-31', 15.90, 'EPO-2025-13', 3),
(20, 'Sea Buckthorn Syrup', 'Supplement', 'Rich in vitamins and immune-boosting.', 14, '2026-02-01', 9.45, 'SBS-2025-14', 5),
(21, 'Rosehip Powder', 'Herbal', 'Vitamin C boost for skin and joints.', 19, '2026-04-10', 7.70, 'RHP-2026-15', 4),
(22, 'Linden Flower Tea', 'Herbal', 'Relieves tension and supports calmness.', 16, '2026-08-01', 5.40, 'LFT-2025-16', 3),
(23, 'Fenugreek Capsules', 'Supplement', 'Supports metabolism and blood sugar.', 13, '2025-12-31', 12.00, 'FGC-2025-17', 4),
(24, 'Hawthorn Extract', 'Herbal', 'Cardiovascular health support.', 6, '2025-10-29', 8.60, 'HWE-2024-18', 5),
(25, 'Licorice Root Lozenges', 'Homeopathic', 'Soothes throat and supports respiration.', 10, '2026-01-01', 4.80, 'LRL-2025-19', 6),
(26, 'Ginkgo Biloba Drops', 'Supplement', 'Supports memory and cognitive function.', 8, '2026-02-11', 13.20, 'GBD-2026-20', 3),
(27, 'Organic Mint Tooth paste', 'Hygiene ', 'Whitens your teeth while not damaging your gums.', 30, '2026-02-28', 4.99, 'SAT_287_SHA', 4),
(28, 'Argan Oil Shampoo', 'Hygiene ', 'It helps to restore moisture and proteins to the hair cuticle, resulting in a softer, shinier, and healthier-looking head of hair.', 40, '2026-05-02', 5.50, 'SUN_231_GUN', 4);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `contact_info` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `contact_info`) VALUES
(1, 'Herbal Naturals Co.', 'herbal@naturals.com / +40712345678'),
(2, 'Bio Remedies Ltd.', 'contact@bioremedies.com / +40787654321'),
(3, 'Organic Wellness', 'support@organicwellness.com / +40749876123'),
(4, 'Nature’s Pureline', 'info@naturespureline.com / +40732104567'),
(5, 'GreenHerb Distributors', 'sales@greenherb.com / +40789231456'),
(6, 'Wellness Botanicals Ltd.', 'contact@wellnessbotanicals.com / +40745678901');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
