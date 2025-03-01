-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 01, 2025 at 04:44 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webbangiay`
--

-- --------------------------------------------------------

--
-- Table structure for table `billdetail`
--

CREATE TABLE `billdetail` (
  `idBill` int DEFAULT NULL,
  `idProduct` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `total` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `idBill` int NOT NULL,
  `idUser` int DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `shippingAddress` varchar(250) DEFAULT NULL,
  `phoneNumber` varchar(11) DEFAULT NULL,
  `totalBill` double DEFAULT NULL,
  `paymentMethod` varchar(250) DEFAULT NULL,
  `statusBill` int DEFAULT '1',
  `statusRemove` int DEFAULT '0',
  `orderTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `approvalTime` timestamp NULL DEFAULT NULL,
  `deliveryTime` timestamp NULL DEFAULT NULL,
  `completionTime` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `idBrand` int NOT NULL,
  `brandName` varchar(100) DEFAULT NULL,
  `imageLogo` varchar(200) DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`idBrand`, `brandName`, `imageLogo`, `createAt`, `updateAt`) VALUES
(1, 'Adidas', './image/logo/adidas.webp', '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(2, 'Air Jordan', './image/logo/jordan.png', '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(3, 'Nike', './image/logo/nike.webp', '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(4, 'Converse', './image/logo/converse.webp', '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(5, 'Puma', './image/logo/puma.webp', '2025-02-26 14:09:11', '2025-02-26 14:09:11');

-- --------------------------------------------------------

--
-- Table structure for table `cartdetail`
--

CREATE TABLE `cartdetail` (
  `idCart` int DEFAULT NULL,
  `idProduct` int DEFAULT NULL,
  `size` double DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `totalProduct` double DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Triggers `cartdetail`
--
DELIMITER $$
CREATE TRIGGER `updateQuantityProduct` AFTER UPDATE ON `cartdetail` FOR EACH ROW BEGIN if (NEW.QUANTITY != OLD.QUANTITY) THEN
UPDATE carts
SET quantityProduct = (
    SELECT SUM(QUANTITY)
    FROM cartDetail
    WHERE IDCART = NEW.IDCART
  ),
  total = (
    SELECT SUM(TOTAL)
    FROM cartDetail
    WHERE IDCART = NEW.IDCART
  )
WHERE IDCART = NEW.IDCART;
END if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `idCart` int NOT NULL,
  `idUser` int DEFAULT NULL,
  `quantityProduct` int DEFAULT '0',
  `total` double DEFAULT '0',
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`idCart`, `idUser`, `quantityProduct`, `total`, `createAt`, `updateAt`) VALUES
(1, 1, 0, 0, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(2, 2, 0, 0, '2025-02-26 14:09:51', '2025-02-26 14:09:51');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation`
--

CREATE TABLE `evaluation` (
  `idEvaluation` int NOT NULL,
  `idBill` int DEFAULT NULL,
  `idProduct` int DEFAULT NULL,
  `content` varchar(250) DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `createAtEvaluation` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `imageproducts`
--

CREATE TABLE `imageproducts` (
  `idImage` int NOT NULL,
  `idProduct` int DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `imageproducts`
--

INSERT INTO `imageproducts` (`idImage`, `idProduct`, `image`) VALUES
(1, 1, './image/products/1.webp'),
(2, 1, './image/products/1-1.webp'),
(3, 1, './image/products/1-2.webp'),
(4, 1, './image/products/1-3.webp'),
(5, 1, './image/products/1-4.webp'),
(6, 2, './image/products/2.webp'),
(7, 2, './image/products/2-1.webp'),
(8, 2, './image/products/2-2.webp'),
(9, 2, './image/products/2-3.webp'),
(10, 3, './image/products/3.webp'),
(11, 3, './image/products/3-1.webp'),
(12, 3, './image/products/3-2.webp'),
(13, 3, './image/products/3-3.webp'),
(14, 3, './image/products/3-4.webp'),
(15, 3, './image/products/3-5.webp'),
(16, 4, './image/products/4.webp'),
(17, 4, './image/products/4-1.webp'),
(18, 4, './image/products/4-2.webp'),
(19, 4, './image/products/4-3.webp'),
(20, 4, './image/products/4-4.webp'),
(21, 4, './image/products/4-5.webp'),
(22, 5, './image/products/5.webp'),
(23, 5, './image/products/5-1.webp'),
(24, 5, './image/products/5-2.webp'),
(25, 5, './image/products/5-3.webp'),
(26, 5, './image/products/5-4.webp'),
(27, 5, './image/products/5-5.webp'),
(28, 6, './image/products/6.webp'),
(29, 6, './image/products/6-1.webp'),
(30, 6, './image/products/6-2.webp'),
(31, 6, './image/products/6-3.webp'),
(32, 6, './image/products/6-4.webp'),
(33, 6, './image/products/6-5.webp'),
(34, 7, './image/products/7.webp'),
(35, 7, './image/products/7-1.webp'),
(36, 7, './image/products/7-2.webp'),
(37, 7, './image/products/7-3.webp'),
(38, 7, './image/products/7-4.webp'),
(39, 7, './image/products/7-5.webp'),
(40, 8, './image/products/8.webp'),
(41, 8, './image/products/8-1.webp'),
(42, 8, './image/products/8-2.webp'),
(43, 8, './image/products/8-3.webp'),
(44, 8, './image/products/8-4.webp'),
(45, 9, './image/products/9.jpg'),
(46, 9, './image/products/9-1.webp'),
(47, 9, './image/products/9-2.webp'),
(48, 9, './image/products/9-3.webp'),
(49, 9, './image/products/9-4.webp'),
(50, 10, './image/products/10.webp'),
(51, 10, './image/products/10-1.webp'),
(52, 10, './image/products/10-2.webp'),
(53, 10, './image/products/10-3.webp'),
(54, 10, './image/products/10-4.webp'),
(55, 11, './image/products/11.webp'),
(56, 11, './image/products/11-1.webp'),
(57, 11, './image/products/11-2.webp'),
(58, 11, './image/products/11-3.webp'),
(59, 11, './image/products/11-4.webp'),
(60, 11, './image/products/11-5.webp'),
(61, 12, './image/products/12.webp'),
(62, 12, './image/products/12-1.webp'),
(63, 12, './image/products/12-2.webp'),
(64, 12, './image/products/12-3.webp'),
(65, 12, './image/products/12-4.webp'),
(66, 13, './image/products/13.webp'),
(67, 13, './image/products/13-1.webp'),
(68, 13, './image/products/13-2.webp'),
(69, 13, './image/products/13-3.webp'),
(70, 13, './image/products/13-4.webp'),
(71, 14, './image/products/14.webp'),
(72, 14, './image/products/14-1.webp'),
(73, 14, './image/products/14-2.webp'),
(74, 14, './image/products/14-3.webp'),
(75, 14, './image/products/14-4.webp'),
(76, 15, './image/products/15.webp'),
(77, 15, './image/products/15-1.webp'),
(78, 15, './image/products/15-2.webp'),
(79, 15, './image/products/15-3.webp'),
(80, 15, './image/products/15-4.webp'),
(81, 16, './image/products/16.webp'),
(82, 16, './image/products/16-1.webp'),
(83, 16, './image/products/16-2.webp'),
(84, 16, './image/products/16-3.webp'),
(85, 16, './image/products/16-4.webp'),
(86, 17, './image/products/17.webp'),
(87, 17, './image/products/17-1.webp'),
(88, 17, './image/products/17-2.webp'),
(89, 17, './image/products/17-3.webp'),
(90, 17, './image/products/17-4.webp'),
(91, 18, './image/products/18.webp'),
(92, 18, './image/products/18-1.webp'),
(93, 18, './image/products/18-2.webp'),
(94, 18, './image/products/18-3.webp'),
(95, 18, './image/products/18-4.webp'),
(96, 19, './image/products/19.webp'),
(97, 19, './image/products/19-1.webp'),
(98, 19, './image/products/19-2.webp'),
(99, 19, './image/products/19-3.webp'),
(100, 19, './image/products/19-4.webp'),
(101, 20, './image/products/20.webp'),
(102, 20, './image/products/20-1.webp'),
(103, 20, './image/products/20-2.webp'),
(104, 20, './image/products/20-3.webp'),
(105, 20, './image/products/20-4.webp'),
(106, 21, './image/products/21.webp'),
(107, 21, './image/products/21-1.webp'),
(108, 21, './image/products/21-2.webp'),
(109, 22, './image/products/22.webp'),
(110, 22, './image/products/22-1.webp'),
(111, 22, './image/products/22-2.webp'),
(112, 22, './image/products/22-3.webp'),
(113, 22, './image/products/22-4.webp'),
(114, 23, './image/products/23.webp'),
(115, 23, './image/products/23-1.webp'),
(116, 23, './image/products/23-2.webp'),
(117, 23, './image/products/23-3.webp'),
(118, 23, './image/products/23-4.webp'),
(119, 24, './image/products/24.webp'),
(120, 24, './image/products/24-1.webp'),
(121, 24, './image/products/24-2.webp'),
(122, 24, './image/products/24-3.webp'),
(123, 24, './image/products/24-4.webp'),
(124, 25, './image/products/25.webp'),
(125, 25, './image/products/25-1.webp'),
(126, 25, './image/products/25-2.webp'),
(127, 25, './image/products/25-3.webp'),
(128, 26, './image/products/26.webp'),
(129, 26, './image/products/26-1.webp'),
(130, 26, './image/products/26-2.webp'),
(131, 26, './image/products/26-3.webp'),
(132, 26, './image/products/26-4.webp'),
(133, 26, './image/products/26-5.webp'),
(134, 27, './image/products/27.webp'),
(135, 27, './image/products/27-1.webp'),
(136, 27, './image/products/27-2.webp'),
(137, 27, './image/products/27-3.webp'),
(138, 28, './image/products/28.webp'),
(139, 28, './image/products/28-1.webp'),
(140, 28, './image/products/28-2.webp'),
(141, 28, './image/products/28-3.webp'),
(142, 28, './image/products/28-4.webp'),
(143, 29, './image/products/29.webp'),
(144, 29, './image/products/29-1.webp'),
(145, 29, './image/products/29-2.webp'),
(146, 30, './image/products/30.webp'),
(147, 30, './image/products/30-1.webp'),
(148, 30, './image/products/30-2.webp'),
(149, 30, './image/products/30-3.webp'),
(150, 30, './image/products/30-4.webp'),
(151, 31, './image/products/31.webp'),
(152, 31, './image/products/31-1.webp'),
(153, 31, './image/products/31-2.webp'),
(154, 32, './image/products/32.webp'),
(155, 32, './image/products/32-1.webp'),
(156, 32, './image/products/32-2.webp'),
(157, 32, './image/products/32-3.webp'),
(158, 32, './image/products/32-4.webp'),
(159, 33, './image/products/33.webp'),
(160, 33, './image/products/33-1.webp'),
(161, 33, './image/products/33-2.webp'),
(162, 33, './image/products/33-3.webp'),
(163, 34, './image/products/34.webp'),
(164, 34, './image/products/34-1.webp'),
(165, 34, './image/products/34-2.webp'),
(166, 35, './image/products/35.webp'),
(167, 35, './image/products/35-1.webp'),
(168, 35, './image/products/35-2.webp'),
(169, 35, './image/products/35-3.webp'),
(170, 36, './image/products/36.webp'),
(171, 36, './image/products/36-1.webp'),
(172, 36, './image/products/36-2.webp'),
(173, 36, './image/products/36-3.webp'),
(174, 37, './image/products/37.webp'),
(175, 37, './image/products/37-1.webp'),
(176, 37, './image/products/37-2.webp'),
(177, 37, './image/products/37-3.webp'),
(178, 37, './image/products/37-4.webp'),
(179, 38, './image/products/38.webp'),
(180, 38, './image/products/38-1.webp'),
(181, 38, './image/products/38-2.webp'),
(182, 38, './image/products/38-3.webp'),
(183, 39, './image/products/39.webp'),
(184, 39, './image/products/39-1.webp'),
(185, 39, './image/products/39-2.webp'),
(186, 39, './image/products/39-3.webp'),
(187, 39, './image/products/39-4.webp'),
(188, 40, './image/products/40.webp'),
(189, 40, './image/products/40-1.webp'),
(190, 40, './image/products/40-2.webp');

-- --------------------------------------------------------

--
-- Table structure for table `permissiongroups`
--

CREATE TABLE `permissiongroups` (
  `idPermission` int NOT NULL,
  `permissionName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `permissiongroups`
--

INSERT INTO `permissiongroups` (`idPermission`, `permissionName`) VALUES
(1, 'Quản lý khách hàng'),
(2, 'Quản lý nhân viên'),
(3, 'Quản lý sản phẩm'),
(4, 'Quản lý bán hàng'),
(5, 'Quản lý nhập hàng'),
(6, 'Quản lý phân quyền'),
(7, 'Quản lý danh mục'),
(8, 'Quản lý nhà cung cấp');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `idProduct` int NOT NULL,
  `idBrand` int DEFAULT NULL,
  `productName` varchar(200) DEFAULT NULL,
  `designType` varchar(150) DEFAULT NULL,
  `oldPrice` double DEFAULT '0',
  `currentPrice` double DEFAULT '0',
  `quantitySold` int DEFAULT '0',
  `status` int DEFAULT '1',
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`idProduct`, `idBrand`, `productName`, `designType`, `oldPrice`, `currentPrice`, `quantitySold`, `status`, `createAt`, `updateAt`) VALUES
(1, 2, 'Giày nam Dior x Air Jordan 1 High', 'Air Jordan 1', 0, 230000000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(2, 2, 'Giày Air Jordan 1 Mid SE All Star 2021 Carbon Fiber (GS)', 'Air Jordan 1 Mid', 10790000, 10090000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(3, 2, 'Giày nam Off-White x Air Jordan 1 Retro High OG ‘UNC’', 'Air Jordan 1 High', 0, 60090000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(4, 2, 'Giày Nike Air Jordan 1 Mid ‘Smoke Grey’', 'Air Jordan 1 Mid', 6490000, 3690000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(5, 2, 'Giày Air Jordan 1 Low Triple White', 'Air Jordan 1 Low', 4690000, 3390000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(6, 2, 'Giày Air Jordan 1 Low ‘Bred Toe’', 'Air Jordan 1', 3690000, 2890000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(7, 2, 'Giày Spider-Man × Nike Air Jordan 1 Retro High OG SP ‘Next Chapter’', 'Air Jordan 1', 6890000, 6390000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(8, 2, 'Giày Dior x Jordan 1 Low Grey', 'Air Jordan 1 Low', 0, 168000000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(9, 3, 'Giày Nike Air Force 1 Low Triple White', 'Air force 1', 3590000, 2590000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(10, 3, 'Giày Louis Vuitton x Nike Air Force 1 Low By Virgil Abloh ‘White Green’', 'Air force 1', 0, 189000000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(11, 3, 'Giày Nike Air Force 1 Low ‘Nail Art’', 'Air force 1', 0, 4890000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(12, 3, 'Giày Nike Air Max Plus 3 ‘Black Grey’', 'Air max', 0, 1990000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(13, 3, 'Giày Nike Air Max 1 ‘Safety Orange’', 'Air max', 0, 4490000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(14, 3, 'Giày nam Nike Blazer Mid ’77 Vintage ‘White Black’', 'Nike blazer', 3690000, 2190000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(15, 3, 'Giày Nike Blazer Mid ‘Mosaic Black Grey’', 'Nike blazer', 3790000, 3390000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(16, 3, 'Giày Nike Blazer Mid ‘Mosaic’', 'Nike blazer', 3790000, 3290000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(17, 1, 'Giày adidas Yeezy Boost 350 V2 CMCPT ‘Slate Bone’', 'Yeezy', 0, 7900000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(18, 1, 'Giày adidas Yeezy Foam RNNR ‘Sand’', 'Yeezy', 9090000, 7890000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(19, 1, 'Giày adidas Yeezy Boost 350 V2 ‘MX Oat’', 'Yeezy', 0, 10690000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(20, 1, 'Giày adidas UltraBoost 4.0 ‘Triple White’', 'Ultra Boost', 5090000, 3890000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(21, 1, 'Giày adidas UltraBoost Uncaged Ltd ‘Black Boost’', 'Ultra Boost', 3090000, 1500000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(22, 1, 'Giày adidas Disney x Stan Smith ‘Black & White Mickey Mouse’', 'Stand Smith', 2490000, 1990000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(23, 1, 'Giày adidas Kris Andrew Small x Stan Smith “Pride”', 'Stand Smith', 0, 2490000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(24, 1, 'Giày adidas Monsters Inc. x Stan Smith ‘Mike Wazowski’', 'Stand Smith', 0, 2890000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(25, 4, 'Giày Converse Chuck 70 Hi ‘Desert Patchwork’', 'Converse 1970s', 2200000, 1390000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(26, 4, 'Giày nam Converse Chuck 70 ‘Amarillo’', 'Converse 1970s', 4690000, 1690000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(27, 4, 'Giày Converse Run Star Hike Hi ‘White’', 'Run Star Hike', 2500000, 1790000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(28, 4, 'Giày Converse Natasha Cloud x Run Star Hike Inspired ‘Floral – Pink Quartz’', 'Run Star Hike', 0, 2890000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(29, 4, 'Giày Converse Run Star Motion Low ‘Black’', 'Run Star Motion', 2600000, 1590000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(30, 4, 'Giày Converse Chuck Taylor All Star ‘White Black’', 'All Star', 2990000, 1490000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(31, 4, 'Giày Converse Comme des Garçons x Chuck Taylor All Star Hi ‘Milk’', 'All Star', 5090000, 3990000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(32, 4, 'Giày Converse Run Star Motion Black Gum ‘Black’', 'Run Star Motion', 0, 3190000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(33, 5, 'Giày Puma RS-X Patent Jr ‘White Yellow Alert’', 'Puma RS', 2500000, 1290000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(34, 5, 'Giày nữ Puma J. Cole x RS-Dreamer 2 ‘Janurary 28th’', 'Puma RS', 0, 4490000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(35, 5, 'Giày Puma RS X3 ‘Olympic’', 'Puma RS', 3190000, 2290000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(36, 5, 'Giày nữ Puma Mule ‘Hologram’', 'Puma Mule', 1890000, 1590000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(37, 5, 'Giày Puma Slip on Bale Bari Mule “Black”', 'Puma Mule', 0, 2090000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(38, 5, 'Giày Puma Thunder Spectra ‘Whisper White’', 'Puma Thunder', 2490000, 2190000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(39, 5, 'Giày nữ Puma Thunder Rive Gauche ‘Grey Peach’', 'Puma Thunder', 0, 3090000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(40, 5, 'Giày nữ Puma Thunder Spectra ‘Sakura’', 'Puma Thunder', 0, 3090000, 0, 1, '2025-02-26 14:09:11', '2025-02-26 14:09:11');

-- --------------------------------------------------------

--
-- Table structure for table `receiptdetail`
--

CREATE TABLE `receiptdetail` (
  `idReceipt` int DEFAULT NULL,
  `idSupplier` int DEFAULT NULL,
  `idProduct` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `pucharsePrice` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `receiptdetail`
--

INSERT INTO `receiptdetail` (`idReceipt`, `idSupplier`, `idProduct`, `size`, `quantity`, `pucharsePrice`) VALUES
(2, 1, 19, 36, 1, 9621000),
(3, 1, 19, 36, 2, 9621000),
(4, 2, 19, 36, 1, 8552000),
(5, 2, 19, 36, 1, 8552000),
(6, 2, 19, 36, 1, 8552000);

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `idReceipt` int NOT NULL,
  `idUser` int DEFAULT NULL,
  `staff` varchar(100) DEFAULT NULL,
  `totalReceipt` double DEFAULT NULL,
  `statusRemove` int DEFAULT '0',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`idReceipt`, `idUser`, `staff`, `totalReceipt`, `statusRemove`, `createTime`) VALUES
(1, 2, 'nguyễn thành nam', 9621000, 0, '2025-02-26 14:15:53'),
(2, 2, 'nguyễn thành nam', 9621000, 0, '2025-02-27 12:30:06'),
(3, 2, 'nguyễn thành nam', 19242000, 0, '2025-02-27 12:31:41'),
(4, 2, 'nguyễn thành nam', 8552000, 0, '2025-02-27 18:05:13'),
(5, 2, 'nguyễn thành nam', 8552000, 0, '2025-02-27 18:05:20'),
(6, 2, 'nguyễn thành nam', 8552000, 0, '2025-02-27 18:05:41');

-- --------------------------------------------------------

--
-- Table structure for table `roledetail`
--

CREATE TABLE `roledetail` (
  `idRole` int DEFAULT NULL,
  `idPermission` int DEFAULT NULL,
  `idTask` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roledetail`
--

INSERT INTO `roledetail` (`idRole`, `idPermission`, `idTask`) VALUES
(2, 3, 1),
(2, 3, 2),
(2, 3, 3),
(2, 4, 1),
(2, 4, 2),
(2, 4, 3),
(2, 5, 1),
(2, 5, 2),
(2, 5, 3),
(2, 6, 1),
(2, 6, 2),
(2, 6, 3),
(2, 7, 1),
(2, 7, 2),
(2, 7, 3),
(2, 8, 1),
(2, 8, 2),
(2, 8, 3);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `idRole` int NOT NULL,
  `roleName` varchar(100) DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`idRole`, `roleName`, `createAt`, `updateAt`) VALUES
(1, 'Khách hàng', '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(2, 'Admin', '2025-02-26 14:09:11', '2025-02-27 12:53:57');

-- --------------------------------------------------------

--
-- Table structure for table `sizeproducts`
--

CREATE TABLE `sizeproducts` (
  `idProduct` int DEFAULT NULL,
  `size` double DEFAULT NULL,
  `statusSize` int DEFAULT '1',
  `quantityRemain` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sizeproducts`
--

INSERT INTO `sizeproducts` (`idProduct`, `size`, `statusSize`, `quantityRemain`) VALUES
(1, 42, 1, 100),
(1, 43, 1, 100),
(1, 44, 1, 100),
(2, 36, 1, 100),
(2, 36.5, 1, 100),
(2, 37, 1, 100),
(2, 37.5, 1, 100),
(2, 38, 1, 100),
(2, 38.5, 1, 100),
(2, 39, 1, 100),
(2, 39.5, 1, 100),
(2, 40, 1, 100),
(3, 41, 1, 100),
(3, 44, 1, 100),
(4, 40, 1, 100),
(4, 40.5, 1, 100),
(4, 41, 1, 100),
(4, 41.5, 1, 100),
(4, 42, 1, 100),
(4, 42.5, 1, 100),
(4, 43, 1, 100),
(4, 43.5, 1, 100),
(4, 44, 1, 100),
(4, 44.5, 1, 100),
(4, 45, 1, 100),
(5, 36, 1, 100),
(5, 36.5, 1, 100),
(5, 37.5, 1, 100),
(5, 40, 1, 100),
(6, 40, 1, 100),
(6, 40.5, 1, 100),
(6, 41, 1, 100),
(6, 42, 1, 100),
(6, 42.5, 1, 100),
(6, 43, 1, 100),
(6, 44, 1, 100),
(7, 40, 1, 100),
(7, 41, 1, 100),
(7, 41.5, 1, 100),
(7, 42, 1, 100),
(7, 43, 1, 100),
(7, 44, 1, 100),
(7, 44.5, 1, 100),
(7, 45, 1, 100),
(8, 36, 1, 100),
(8, 36.5, 1, 100),
(8, 37, 1, 100),
(8, 37.5, 1, 100),
(8, 38, 1, 100),
(8, 38.5, 1, 100),
(8, 39, 1, 100),
(8, 40, 1, 100),
(9, 36, 1, 100),
(9, 36.5, 1, 100),
(9, 37, 1, 100),
(9, 37.5, 1, 100),
(9, 38, 1, 100),
(9, 38.5, 1, 100),
(9, 39, 1, 100),
(9, 40, 1, 100),
(10, 42.5, 1, 100),
(11, 35.5, 1, 100),
(11, 36, 1, 100),
(11, 36.5, 1, 100),
(11, 37, 1, 100),
(11, 38, 1, 100),
(12, 38.5, 1, 100),
(13, 36.5, 1, 100),
(13, 37, 1, 100),
(13, 37.5, 1, 100),
(13, 38, 1, 100),
(13, 38.5, 1, 100),
(13, 39, 1, 100),
(13, 40, 1, 100),
(14, 40, 1, 100),
(14, 40.5, 1, 100),
(14, 41, 1, 100),
(14, 41.5, 1, 100),
(14, 42, 1, 100),
(14, 43, 1, 100),
(15, 36, 1, 100),
(15, 36.5, 1, 100),
(15, 37.5, 1, 100),
(15, 38.5, 1, 100),
(15, 39, 1, 100),
(15, 40, 1, 100),
(16, 38, 1, 100),
(17, 36, 1, 100),
(17, 38, 1, 100),
(17, 40, 1, 100),
(17, 42, 1, 100),
(17, 44, 1, 100),
(18, 37, 1, 100),
(18, 38, 1, 100),
(18, 39, 1, 100),
(18, 40.5, 1, 100),
(18, 42, 1, 100),
(19, 36, 1, 107),
(19, 36.5, 1, 100),
(19, 38, 1, 100),
(19, 39.5, 1, 100),
(19, 40, 1, 100),
(19, 41, 1, 100),
(20, 40, 1, 100),
(21, 40, 1, 100),
(22, 37, 1, 100),
(22, 40, 1, 100),
(22, 42, 1, 100),
(23, 40, 1, 100),
(23, 40.5, 1, 100),
(23, 42, 1, 100),
(23, 44, 1, 100),
(24, 36, 1, 100),
(24, 36.5, 1, 100),
(24, 37, 1, 100),
(24, 38, 1, 100),
(24, 40, 1, 100),
(25, 39, 1, 100),
(25, 40, 1, 100),
(25, 41, 1, 100),
(25, 41.5, 1, 100),
(26, 40, 1, 100),
(26, 41, 1, 100),
(26, 42, 1, 100),
(26, 42.5, 1, 100),
(26, 43, 1, 100),
(26, 44, 1, 100),
(27, 36, 1, 100),
(27, 36.5, 1, 100),
(27, 37, 1, 100),
(27, 37.5, 1, 100),
(27, 38, 1, 100),
(27, 39, 1, 100),
(27, 40, 1, 100),
(27, 41, 1, 100),
(27, 42, 1, 100),
(28, 36.5, 1, 100),
(28, 37, 1, 100),
(28, 37.5, 1, 100),
(28, 38, 1, 100),
(28, 38.5, 1, 100),
(28, 39, 1, 100),
(29, 36, 1, 100),
(29, 37, 1, 100),
(29, 38, 1, 100),
(29, 39, 1, 100),
(29, 40, 1, 100),
(30, 38, 1, 100),
(30, 39, 1, 100),
(30, 40, 1, 100),
(31, 41.5, 1, 100),
(31, 42, 1, 100),
(32, 36, 1, 100),
(32, 36.5, 1, 100),
(32, 37.5, 1, 100),
(33, 39, 1, 100),
(34, 35.5, 1, 100),
(34, 36, 1, 100),
(34, 36.5, 1, 100),
(34, 37, 1, 100),
(34, 37.5, 1, 100),
(34, 38, 1, 100),
(34, 38.5, 1, 100),
(34, 39, 1, 100),
(35, 35.5, 1, 100),
(35, 36, 1, 100),
(35, 36.5, 1, 100),
(35, 37.5, 1, 100),
(35, 38, 1, 100),
(35, 40, 1, 100),
(36, 35.5, 1, 100),
(36, 36, 1, 100),
(36, 36.5, 1, 100),
(36, 37.5, 1, 100),
(36, 38, 1, 100),
(36, 39, 1, 100),
(37, 40, 1, 100),
(38, 38, 1, 100),
(38, 38.5, 1, 100),
(39, 35.5, 1, 100),
(39, 36, 1, 100),
(39, 36.5, 1, 100),
(39, 37.5, 1, 100),
(39, 38, 1, 100),
(39, 38.5, 1, 100),
(40, 35.5, 1, 100),
(40, 37.5, 1, 100),
(40, 38, 1, 100),
(40, 40, 1, 100);

-- --------------------------------------------------------

--
-- Table structure for table `subbrands`
--

CREATE TABLE `subbrands` (
  `idBrand` int DEFAULT NULL,
  `subBrandName` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subbrands`
--

INSERT INTO `subbrands` (`idBrand`, `subBrandName`) VALUES
(1, 'Yeezy'),
(1, 'Ultra Boost'),
(1, 'Stand Smith'),
(2, 'Air Jordan 1'),
(2, 'Air Jordan 1 Low'),
(2, 'Air Jordan 1 Mid'),
(2, 'Air Jordan 1 High'),
(3, 'Air force 1'),
(3, 'Air max'),
(3, 'Nike blazer'),
(4, 'Converse 1970s'),
(4, 'Run Star Hike'),
(4, 'Run Star Motion'),
(4, 'All Star'),
(5, 'Puma RS'),
(5, 'Puma Mule'),
(5, 'Puma Thunder');

-- --------------------------------------------------------

--
-- Table structure for table `supplierdetail`
--

CREATE TABLE `supplierdetail` (
  `idSupplier` int DEFAULT NULL,
  `idProduct` int DEFAULT NULL,
  `price` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `supplierdetail`
--

INSERT INTO `supplierdetail` (`idSupplier`, `idProduct`, `price`) VALUES
(1, 1, 207000000),
(1, 2, 9081000),
(1, 3, 54081000),
(1, 4, 3321000),
(1, 5, 3051000),
(1, 6, 2601000),
(1, 12, 1791000),
(1, 13, 4041000),
(1, 14, 1971000),
(1, 15, 3051000),
(1, 16, 2961000),
(1, 17, 7110000),
(1, 18, 7101000),
(1, 23, 2241000),
(1, 24, 2601000),
(1, 25, 1251000),
(1, 26, 1521000),
(1, 27, 1611000),
(1, 31, 3591000),
(1, 32, 2871000),
(1, 33, 1161000),
(1, 39, 2781000),
(1, 40, 2781000),
(2, 1, 184000000),
(2, 2, 8072000),
(2, 3, 48072000),
(2, 4, 2952000),
(2, 5, 2712000),
(2, 6, 2312000),
(2, 7, 5112000),
(2, 8, 134400000),
(2, 9, 2072000),
(2, 10, 151200000),
(2, 11, 3912000),
(2, 12, 1592000),
(2, 13, 3592000),
(2, 14, 1752000),
(2, 15, 2712000),
(2, 16, 2632000),
(2, 17, 6320000),
(2, 18, 6312000),
(2, 19, 8552000),
(2, 20, 3112000),
(2, 21, 1200000),
(2, 22, 1592000),
(2, 23, 1992000),
(2, 24, 2312000),
(2, 25, 1112000),
(2, 26, 1352000),
(2, 27, 1432000),
(2, 28, 2312000),
(2, 29, 1272000),
(2, 30, 1192000),
(2, 31, 3192000),
(2, 32, 2552000),
(2, 33, 1032000),
(2, 34, 3592000),
(2, 35, 1832000),
(2, 36, 1272000),
(2, 37, 1672000),
(2, 38, 1752000),
(2, 39, 2472000),
(2, 40, 2472000),
(3, 2, 8576500),
(3, 4, 3136500),
(3, 6, 2456500),
(3, 8, 142800000),
(3, 10, 160650000),
(3, 12, 1691500),
(3, 14, 1861500),
(3, 16, 2796500),
(3, 18, 6706500),
(3, 28, 2456500),
(3, 30, 1266500),
(3, 32, 2711500),
(3, 34, 3816500),
(3, 36, 1351500),
(3, 38, 1861500),
(3, 40, 2626500),
(4, 17, 10000),
(4, 18, 10000000);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `idSupplier` int NOT NULL,
  `nameSupplier` varchar(255) NOT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `addressSupplier` varchar(250) DEFAULT NULL,
  `statusRemove` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`idSupplier`, `nameSupplier`, `phoneNumber`, `email`, `addressSupplier`, `statusRemove`, `created_at`) VALUES
(1, 'Golden Road Fashion', '0123456789', 'goldenroadfashion@gmail.com', '36 Phan Huy Ich P15 QTanBinh TP Ho Chi Minh', 0, '2025-02-26 14:09:11'),
(2, 'Supersports Vietnam', '02466892228', 'ce@supersports.com.vn', 'TTTM Lotte Mall Tây Hồ, Hà Nội', 0, '2025-02-26 14:09:11'),
(3, 'The Fire Monkey', '0983151780', 'tfm3017@gmail.com', '24 khối 1B, Đông Anh, Hà Nội', 0, '2025-02-26 14:09:11'),
(4, 'G-Lab', '0945378809', 'glabvn@gmail.com', '135/58 Trần Hưng Đạo, Phường Cầu Ông Lãnh, Quận 1, TP. Hồ Chí Minh', 0, '2025-02-26 14:09:11');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `idTask` int NOT NULL,
  `taskName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`idTask`, `taskName`) VALUES
(1, 'thêm'),
(2, 'xoá'),
(3, 'sửa'),
(4, 'xem');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `idUser` int NOT NULL,
  `idRole` int DEFAULT '1',
  `fullName` varchar(100) DEFAULT NULL,
  `phoneNumber` varchar(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT './avatar/default-avatar.jpg',
  `status` int DEFAULT '1',
  `statusRemove` int DEFAULT '0',
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`idUser`, `idRole`, `fullName`, `phoneNumber`, `username`, `password`, `email`, `avatar`, `status`, `statusRemove`, `createAt`, `updateAt`) VALUES
(1, 2, 'admin', '0123456789', 'admin123', '$2y$10$bgyVh0xTbFU8kFRVan1AK.lh03ISwS53j0162crPEby.Y90k85CUC', NULL, './avatar/default-avatar.jpg', 1, 0, '2025-02-26 14:09:11', '2025-02-26 14:09:11'),
(2, 2, 'nguyễn thành nam', '0912345678', 'thanhnam123', '$2y$10$5gSznaOeH2OcipJpAKlDVOO0ip214yZOFuH316681YhWuTZLYd3Lm', NULL, './avatar/default-avatar.jpg', 1, 0, '2025-02-26 14:09:51', '2025-02-26 14:10:00');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `createCart` AFTER INSERT ON `users` FOR EACH ROW BEGIN
INSERT INTO CARTS (IDUSER)
VALUES (NEW.IDUSER);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `usershippingaddress`
--

CREATE TABLE `usershippingaddress` (
  `idAddress` int NOT NULL,
  `idUser` int DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phoneNumber` varchar(11) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `status` int DEFAULT '0',
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billdetail`
--
ALTER TABLE `billdetail`
  ADD KEY `idBill` (`idBill`),
  ADD KEY `idProduct` (`idProduct`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`idBill`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`idBrand`);

--
-- Indexes for table `cartdetail`
--
ALTER TABLE `cartdetail`
  ADD KEY `idCart` (`idCart`),
  ADD KEY `idProduct` (`idProduct`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`idCart`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`idEvaluation`),
  ADD KEY `idBill` (`idBill`),
  ADD KEY `idProduct` (`idProduct`);

--
-- Indexes for table `imageproducts`
--
ALTER TABLE `imageproducts`
  ADD PRIMARY KEY (`idImage`),
  ADD KEY `idProduct` (`idProduct`);

--
-- Indexes for table `permissiongroups`
--
ALTER TABLE `permissiongroups`
  ADD PRIMARY KEY (`idPermission`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `idBrand` (`idBrand`);

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`idReceipt`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `roledetail`
--
ALTER TABLE `roledetail`
  ADD KEY `idRole` (`idRole`),
  ADD KEY `idPermission` (`idPermission`),
  ADD KEY `idTask` (`idTask`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRole`);

--
-- Indexes for table `sizeproducts`
--
ALTER TABLE `sizeproducts`
  ADD KEY `idProduct` (`idProduct`);

--
-- Indexes for table `subbrands`
--
ALTER TABLE `subbrands`
  ADD KEY `idBrand` (`idBrand`);

--
-- Indexes for table `supplierdetail`
--
ALTER TABLE `supplierdetail`
  ADD KEY `idSupplier` (`idSupplier`),
  ADD KEY `idProduct` (`idProduct`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`idSupplier`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`idTask`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`idUser`),
  ADD KEY `idRole` (`idRole`);

--
-- Indexes for table `usershippingaddress`
--
ALTER TABLE `usershippingaddress`
  ADD PRIMARY KEY (`idAddress`),
  ADD KEY `idUser` (`idUser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `idBill` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `idBrand` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `idCart` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `evaluation`
--
ALTER TABLE `evaluation`
  MODIFY `idEvaluation` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `imageproducts`
--
ALTER TABLE `imageproducts`
  MODIFY `idImage` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=191;

--
-- AUTO_INCREMENT for table `permissiongroups`
--
ALTER TABLE `permissiongroups`
  MODIFY `idPermission` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `idProduct` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `idReceipt` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `idRole` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `idSupplier` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `idTask` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `idUser` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usershippingaddress`
--
ALTER TABLE `usershippingaddress`
  MODIFY `idAddress` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `billdetail`
--
ALTER TABLE `billdetail`
  ADD CONSTRAINT `billdetail_ibfk_1` FOREIGN KEY (`idBill`) REFERENCES `bills` (`idBill`),
  ADD CONSTRAINT `billdetail_ibfk_2` FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);

--
-- Constraints for table `cartdetail`
--
ALTER TABLE `cartdetail`
  ADD CONSTRAINT `cartdetail_ibfk_1` FOREIGN KEY (`idCart`) REFERENCES `carts` (`idCart`),
  ADD CONSTRAINT `cartdetail_ibfk_2` FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);

--
-- Constraints for table `evaluation`
--
ALTER TABLE `evaluation`
  ADD CONSTRAINT `evaluation_ibfk_1` FOREIGN KEY (`idBill`) REFERENCES `bills` (`idBill`),
  ADD CONSTRAINT `evaluation_ibfk_2` FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);

--
-- Constraints for table `imageproducts`
--
ALTER TABLE `imageproducts`
  ADD CONSTRAINT `imageproducts_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`idBrand`) REFERENCES `brands` (`idBrand`);

--
-- Constraints for table `receipts`
--
ALTER TABLE `receipts`
  ADD CONSTRAINT `receipts_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);

--
-- Constraints for table `roledetail`
--
ALTER TABLE `roledetail`
  ADD CONSTRAINT `roledetail_ibfk_1` FOREIGN KEY (`idRole`) REFERENCES `roles` (`idRole`),
  ADD CONSTRAINT `roledetail_ibfk_2` FOREIGN KEY (`idPermission`) REFERENCES `permissiongroups` (`idPermission`),
  ADD CONSTRAINT `roledetail_ibfk_3` FOREIGN KEY (`idTask`) REFERENCES `tasks` (`idTask`);

--
-- Constraints for table `sizeproducts`
--
ALTER TABLE `sizeproducts`
  ADD CONSTRAINT `sizeproducts_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);

--
-- Constraints for table `subbrands`
--
ALTER TABLE `subbrands`
  ADD CONSTRAINT `subbrands_ibfk_1` FOREIGN KEY (`idBrand`) REFERENCES `brands` (`idBrand`);

--
-- Constraints for table `supplierdetail`
--
ALTER TABLE `supplierdetail`
  ADD CONSTRAINT `supplierdetail_ibfk_1` FOREIGN KEY (`idSupplier`) REFERENCES `suppliers` (`idSupplier`),
  ADD CONSTRAINT `supplierdetail_ibfk_2` FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`idRole`) REFERENCES `roles` (`idRole`);

--
-- Constraints for table `usershippingaddress`
--
ALTER TABLE `usershippingaddress`
  ADD CONSTRAINT `usershippingaddress_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
