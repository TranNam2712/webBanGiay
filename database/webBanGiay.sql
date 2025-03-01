CREATE TABLE `roles` (
  `idRole` int PRIMARY KEY AUTO_INCREMENT,
  `roleName` varchar(100),
  `createAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `permissionGroups` (
  `idPermission` int PRIMARY KEY AUTO_INCREMENT,
  `permissionName` varchar(100)
);
CREATE TABLE `tasks` (
  `idTask` int PRIMARY KEY AUTO_INCREMENT,
  `taskName` varchar(50)
);
CREATE TABLE `roleDetail` (
  `idRole` int,
  `idPermission` int,
  `idTask` int
);
CREATE TABLE `users` (
  `idUser` int PRIMARY KEY AUTO_INCREMENT,
  `idRole` int DEFAULT 1,
  `fullName` varchar(100),
  `phoneNumber` varchar(11),
  `username` varchar(100),
  `password` varchar(100),
  `email` varchar(100),
  `avatar` varchar(100) DEFAULT './avatar/default-avatar.jpg',
  `status` int DEFAULT 1,
  `statusRemove` int DEFAULT 0,
  `createAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `brands` (
  `idBrand` int PRIMARY KEY AUTO_INCREMENT,
  `brandName` varchar(100),
  `imageLogo` varchar(200),
  `createAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `subBrands` (`idBrand` int, `subBrandName` varchar(150));
CREATE TABLE `products` (
  `idProduct` int PRIMARY KEY AUTO_INCREMENT,
  `idBrand` int,
  `productName` varchar(200),
  `designType` varchar(150),
  `oldPrice` double DEFAULT 0,
  `currentPrice` double DEFAULT 0,
  `quantitySold` int DEFAULT 0,
  `status` int DEFAULT 1,
  `createAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `sizeProducts` (
  `idProduct` int,
  `size` DOUBLE,
  `statusSize` INT DEFAULT 1,
  `quantityRemain` int DEFAULT 0
);
CREATE TABLE `imageProducts` (
  `idImage` INT PRIMARY KEY AUTO_INCREMENT,
  `idProduct` int,
  `image` varchar(200)
);
CREATE TABLE `carts` (
  `idCart` int PRIMARY KEY AUTO_INCREMENT,
  `idUser` int,
  `quantityProduct` int DEFAULT 0,
  `total` double DEFAULT 0,
  `createAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `cartDetail` (
  `idCart` int,
  `idProduct` int,
  `size` double,
  `quantity` int,
  `totalProduct` double,
  `createAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `bills` (
  `idBill` int PRIMARY KEY AUTO_INCREMENT,
  `idUser` int,
  `receiver` varchar(100),
  `shippingAddress` varchar(250),
  `phoneNumber` varchar(11),
  `totalBill` double,
  `paymentMethod` varchar(250),
  `statusBill` int DEFAULT 1,
  `statusRemove` int DEFAULT 0,
  `orderTime` timestamp DEFAULT CURRENT_TIMESTAMP,
  `approvalTime` timestamp Null,
  `deliveryTime` timestamp Null,
  `completionTime` timestamp Null
);
CREATE TABLE `billDetail` (
  `idBill` int,
  `idProduct` int,
  `size` int,
  `quantity` int,
  `total` int
);
CREATE TABLE `receipts` (
  `idReceipt` int PRIMARY KEY AUTO_INCREMENT,
  `idUser` int,
  `staff` varchar(100),
  `totalReceipt` double,
  `statusRemove` int DEFAULT 0,
  `createTime` timestamp DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `suppliers` (
    `idSupplier` INT AUTO_INCREMENT PRIMARY KEY,
    `nameSupplier` VARCHAR(255) NOT NULL,
    `phoneNumber` VARCHAR(20),
    `email` VARCHAR(255),
    `addressSupplier` varchar(250),
  `statusRemove` int DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `supplierDetail` (
  `idSupplier` int,
  `idProduct` int,
  `price` int
);
CREATE TABLE `receiptDetail` (
  `idReceipt` int,
    `idSupplier` int,
  `idProduct` int,
  `size` int,
  `quantity` int,
  `pucharsePrice` int
);
CREATE TABLE `userShippingAddress` (
  `idAddress` int PRIMARY KEY AUTO_INCREMENT,
  `idUser` int,
  `name` varchar(100),
  `phoneNumber` varchar(11),
  `address` varchar(250),
  status int DEFAULT 0,
  `createAt` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `evaluation` (
  `idEvaluation` int PRIMARY KEY AUTO_INCREMENT,
  `idBill` int,
  `idProduct` int,
  `content` varchar(250),
  `rating` int,
  `createAtEvaluation` timestamp DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE `roleDetail`
ADD FOREIGN KEY (`idRole`) REFERENCES `roles` (`idRole`);
ALTER TABLE `roleDetail`
ADD FOREIGN KEY (`idPermission`) REFERENCES `permissionGroups` (`idPermission`);
ALTER TABLE `roleDetail`
ADD FOREIGN KEY (`idTask`) REFERENCES `tasks` (`idTask`);
ALTER TABLE `users`
ADD FOREIGN KEY (`idRole`) REFERENCES `roles` (`idRole`);
ALTER TABLE `subBrands`
ADD FOREIGN KEY (`idBrand`) REFERENCES `brands` (`idBrand`);
ALTER TABLE `products`
ADD FOREIGN KEY (`idBrand`) REFERENCES `brands` (`idBrand`);
ALTER TABLE `sizeProducts`
ADD FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);
ALTER TABLE `imageProducts`
ADD FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);
ALTER TABLE `carts`
ADD FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);
ALTER TABLE `cartDetail`
ADD FOREIGN KEY (`idCart`) REFERENCES `carts` (`idCart`);
ALTER TABLE `cartDetail`
ADD FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);
ALTER TABLE `bills`
ADD FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);
ALTER TABLE `receipts`
ADD FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);
ALTER TABLE `receiptDetail`
ADD FOREIGN KEY (`idSupplier`) REFERENCES `suppliers` (`idSupplier`);
ALTER TABLE `billDetail`
ADD FOREIGN KEY (`idBill`) REFERENCES `bills` (`idBill`);
ALTER TABLE `receiptDetail`
ADD FOREIGN KEY (`idReceipt`) REFERENCES `receipts` (`idReceipt`);
ALTER TABLE `billDetail`
ADD FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);
ALTER TABLE `receiptDetail`
ADD FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);
ALTER TABLE `supplierDetail`
ADD FOREIGN KEY (`idSupplier`) REFERENCES `suppliers` (`idSupplier`);
ALTER TABLE `supplierDetail`
ADD FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);
ALTER TABLE `userShippingAddress`
ADD FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);
ALTER TABLE `evaluation`
ADD FOREIGN KEY (`idBill`) REFERENCES `bills` (`idBill`);
ALTER TABLE `evaluation`
ADD FOREIGN KEY (`idProduct`) REFERENCES `products` (`idProduct`);
-- trigger createCart--
DELIMITER $$ CREATE TRIGGER `createCart`
AFTER
INSERT ON `users` FOR EACH ROW BEGIN
INSERT INTO CARTS (IDUSER)
VALUES (NEW.IDUSER);
END $$ DELIMITER;
-- trigger update quantity product by cart detail--
DELIMITER $$ CREATE TRIGGER `updateQuantityProduct`
AFTER
update ON `cartDetail` FOR EACH ROW BEGIN if (NEW.QUANTITY != OLD.QUANTITY) THEN
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
END $$ DELIMITER;
-- insert data tasks--
INSERT INTO tasks (taskName)
VALUES ('thêm'),
  ('xoá'),
  ('sửa'),
  ('xem');
-- insert data permissionGroups--
INSERT INTO permissionGroups (permissionName)
VALUES ('Quản lý khách hàng'),
  ('Quản lý nhân viên'),
  ('Quản lý sản phẩm'),
  ('Quản lý bán hàng'),
  ('Quản lý nhập hàng'),
  ('Quản lý phân quyền'),
  ('Quản lý danh mục'),
  ('Quản lý nhà cung cấp');
-- insert data roles--
INSERT INTO roles (roleName)
VALUES ('Khách hàng'),
('Admin');
-- insert data roleDetail--
INSERT INTO roledetail (idRole, idPermission, idTask)
VALUES (2, 6, 1),
(2, 6, 2),
(2, 6, 3);
-- INSERT DATA brands--
INSERT into brands (brandName, imageLogo)
values ('Adidas', './image/logo/adidas.webp'),
  ('Air Jordan', './image/logo/jordan.png'),
  ('Nike', './image/logo/nike.webp'),
  ('Converse', './image/logo/converse.webp'),
  ('Puma', './image/logo/puma.webp');
-- INSERT DATA subBrands--
INSERT INTO subBrands (idBrand, subBrandName) -- Adidas
values (1, 'Yeezy'),
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
-- INSERT DATA products--
insert into products (
    idBrand,
    productName,
    designType,
    oldPrice,
    currentPrice,
    quantitySold
  )
values (
    2,
    'Giày nam Dior x Air Jordan 1 High',
    'Air Jordan 1',
    0,
    230000000,
    0
  ),
  (
    2,
    'Giày Air Jordan 1 Mid SE All Star 2021 Carbon Fiber (GS)',
    'Air Jordan 1 Mid',
    10790000,
    10090000,
    0
  ),
  (
    2,
    'Giày nam Off-White x Air Jordan 1 Retro High OG ‘UNC’',
    'Air Jordan 1 High',
    0,
    60090000,
    0
  ),
  (
    2,
    'Giày Nike Air Jordan 1 Mid ‘Smoke Grey’',
    'Air Jordan 1 Mid',
    6490000,
    3690000,
    0
  ),
  (
    2,
    'Giày Air Jordan 1 Low Triple White',
    'Air Jordan 1 Low',
    4690000,
    3390000,
    0
  ),
  (
    2,
    'Giày Air Jordan 1 Low ‘Bred Toe’',
    'Air Jordan 1',
    3690000,
    2890000,
    0
  ),
  (
    2,
    'Giày Spider-Man × Nike Air Jordan 1 Retro High OG SP ‘Next Chapter’',
    'Air Jordan 1',
    6890000,
    6390000,
    0
  ),
  (
    2,
    'Giày Dior x Jordan 1 Low Grey',
    'Air Jordan 1 Low',
    0,
    168000000,
    0
  ),
  (
    3,
    'Giày Nike Air Force 1 Low Triple White',
    'Air force 1',
    3590000,
    2590000,
    0
  ),
  (
    3,
    'Giày Louis Vuitton x Nike Air Force 1 Low By Virgil Abloh ‘White Green’',
    'Air force 1',
    0,
    189000000,
    0
  ),
  (
    3,
    'Giày Nike Air Force 1 Low ‘Nail Art’',
    'Air force 1',
    0,
    4890000,
    0
  ),
  (
    3,
    'Giày Nike Air Max Plus 3 ‘Black Grey’',
    'Air max',
    0,
    1990000,
    0
  ),
  (
    3,
    'Giày Nike Air Max 1 ‘Safety Orange’',
    'Air max',
    0,
    4490000,
    0
  ),
  (
    3,
    'Giày nam Nike Blazer Mid ’77 Vintage ‘White Black’',
    'Nike blazer',
    3690000,
    2190000,
    0
  ),
  (
    3,
    'Giày Nike Blazer Mid ‘Mosaic Black Grey’',
    'Nike blazer',
    3790000,
    3390000,
    0
  ),
  (
    3,
    'Giày Nike Blazer Mid ‘Mosaic’',
    'Nike blazer',
    3790000,
    3290000,
    0
  ),
  (
    1,
    'Giày adidas Yeezy Boost 350 V2 CMCPT ‘Slate Bone’',
    'Yeezy',
    0,
    7900000,
    0
  ),
  (
    1,
    'Giày adidas Yeezy Foam RNNR ‘Sand’',
    'Yeezy',
    9090000,
    7890000,
    0
  ),
  (
    1,
    'Giày adidas Yeezy Boost 350 V2 ‘MX Oat’',
    'Yeezy',
    0,
    10690000,
    0
  ),
  (
    1,
    'Giày adidas UltraBoost 4.0 ‘Triple White’',
    'Ultra Boost',
    5090000,
    3890000,
    0
  ),
  (
    1,
    'Giày adidas UltraBoost Uncaged Ltd ‘Black Boost’',
    'Ultra Boost',
    3090000,
    1500000,
    0
  ),
  (
    1,
    'Giày adidas Disney x Stan Smith ‘Black & White Mickey Mouse’',
    'Stand Smith',
    2490000,
    1990000,
    0
  ),
  (
    1,
    'Giày adidas Kris Andrew Small x Stan Smith “Pride”',
    'Stand Smith',
    0,
    2490000,
    0
  ),
  (
    1,
    'Giày adidas Monsters Inc. x Stan Smith ‘Mike Wazowski’',
    'Stand Smith',
    0,
    2890000,
    0
  ),
  (
    4,
    'Giày Converse Chuck 70 Hi ‘Desert Patchwork’',
    'Converse 1970s',
    2200000,
    1390000,
    0
  ),
  (
    4,
    'Giày nam Converse Chuck 70 ‘Amarillo’',
    'Converse 1970s',
    4690000,
    1690000,
    0
  ),
  (
    4,
    'Giày Converse Run Star Hike Hi ‘White’',
    'Run Star Hike',
    2500000,
    1790000,
    0
  ),
  (
    4,
    'Giày Converse Natasha Cloud x Run Star Hike Inspired ‘Floral – Pink Quartz’',
    'Run Star Hike',
    0,
    2890000,
    0
  ),
  (
    4,
    'Giày Converse Run Star Motion Low ‘Black’',
    'Run Star Motion',
    2600000,
    1590000,
    0
  ),
  (
    4,
    'Giày Converse Chuck Taylor All Star ‘White Black’',
    'All Star',
    2990000,
    1490000,
    0
  ),
  (
    4,
    'Giày Converse Comme des Garçons x Chuck Taylor All Star Hi ‘Milk’',
    'All Star',
    5090000,
    3990000,
    0
  ),
  (
    4,
    'Giày Converse Run Star Motion Black Gum ‘Black’',
    'Run Star Motion',
    0,
    3190000,
    0
  ),
  (
    5,
    'Giày Puma RS-X Patent Jr ‘White Yellow Alert’',
    'Puma RS',
    2500000,
    1290000,
    0
  ),
  (
    5,
    'Giày nữ Puma J. Cole x RS-Dreamer 2 ‘Janurary 28th’',
    'Puma RS',
    0,
    4490000,
    0
  ),
  (
    5,
    'Giày Puma RS X3 ‘Olympic’',
    'Puma RS',
    3190000,
    2290000,
    0
  ),
  (
    5,
    'Giày nữ Puma Mule ‘Hologram’',
    'Puma Mule',
    1890000,
    1590000,
    0
  ),
  (
    5,
    'Giày Puma Slip on Bale Bari Mule “Black”',
    'Puma Mule',
    0,
    2090000,
    0
  ),
  (
    5,
    'Giày Puma Thunder Spectra ‘Whisper White’',
    'Puma Thunder',
    2490000,
    2190000,
    0
  ),
  (
    5,
    'Giày nữ Puma Thunder Rive Gauche ‘Grey Peach’',
    'Puma Thunder',
    0,
    3090000,
    0
  ),
  (
    5,
    'Giày nữ Puma Thunder Spectra ‘Sakura’',
    'Puma Thunder',
    0,
    3090000,
    0
  );
-- insert data sizeProducts--
INSERT INTO sizeProducts (idProduct, size)
VALUES (1, 42),
  (1, 43),
  (1, 44),
  (2, 36),
  (2, 36.5),
  (2, 37),
  (2, 37.5),
  (2, 38),
  (2, 38.5),
  (2, 39),
  (2, 39.5),
  (2, 40),
  (3, 41),
  (3, 44),
  (4, 40),
  (4, 40.5),
  (4, 41),
  (4, 41.5),
  (4, 42),
  (4, 42.5),
  (4, 43),
  (4, 43.5),
  (4, 44),
  (4, 44.5),
  (4, 45),
  (5, 36),
  (5, 36.5),
  (5, 37.5),
  (5, 40),
  (6, 40),
  (6, 40.5),
  (6, 41),
  (6, 42),
  (6, 42.5),
  (6, 43),
  (6, 44),
  (7, 40),
  (7, 41),
  (7, 41.5),
  (7, 42),
  (7, 43),
  (7, 44),
  (7, 44.5),
  (7, 45),
  (8, 36),
  (8, 36.5),
  (8, 37),
  (8, 37.5),
  (8, 38),
  (8, 38.5),
  (8, 39),
  (8, 40),
  (9, 36),
  (9, 36.5),
  (9, 37),
  (9, 37.5),
  (9, 38),
  (9, 38.5),
  (9, 39),
  (9, 40),
  (10, 42.5),
  (11, 35.5),
  (11, 36),
  (11, 36.5),
  (11, 37),
  (11, 38),
  (12, 38.5),
  (13, 36.5),
  (13, 37),
  (13, 37.5),
  (13, 38),
  (13, 38.5),
  (13, 39),
  (13, 40),
  (14, 40),
  (14, 40.5),
  (14, 41),
  (14, 41.5),
  (14, 42),
  (14, 43),
  (15, 36),
  (15, 36.5),
  (15, 37.5),
  (15, 38.5),
  (15, 39),
  (15, 40),
  (16, 38),
  (17, 36),
  (17, 38),
  (17, 40),
  (17, 42),
  (17, 44),
  (18, 37),
  (18, 38),
  (18, 39),
  (18, 40.5),
  (18, 42),
  (19, 36),
  (19, 36.5),
  (19, 38),
  (19, 39.5),
  (19, 40),
  (19, 41),
  (20, 40),
  (21, 40),
  (22, 37),
  (22, 40),
  (22, 42),
  (23, 40),
  (23, 40.5),
  (23, 42),
  (23, 44),
  (24, 36),
  (24, 36.5),
  (24, 37),
  (24, 38),
  (24, 40),
  (25, 39),
  (25, 40),
  (25, 41),
  (25, 41.5),
  (26, 40),
  (26, 41),
  (26, 42),
  (26, 42.5),
  (26, 43),
  (26, 44),
  (27, 36),
  (27, 36.5),
  (27, 37),
  (27, 37.5),
  (27, 38),
  (27, 39),
  (27, 40),
  (27, 41),
  (27, 42),
  (28, 36.5),
  (28, 37),
  (28, 37.5),
  (28, 38),
  (28, 38.5),
  (28, 39),
  (29, 36),
  (29, 37),
  (29, 38),
  (29, 39),
  (29, 40),
  (30, 38),
  (30, 39),
  (30, 40),
  (31, 41.5),
  (31, 42),
  (32, 36),
  (32, 36.5),
  (32, 37.5),
  (33, 39),
  (34, 35.5),
  (34, 36),
  (34, 36.5),
  (34, 37),
  (34, 37.5),
  (34, 38),
  (34, 38.5),
  (34, 39),
  (35, 35.5),
  (35, 36),
  (35, 36.5),
  (35, 37.5),
  (35, 38),
  (35, 40),
  (36, 35.5),
  (36, 36),
  (36, 36.5),
  (36, 37.5),
  (36, 38),
  (36, 39),
  (37, 40),
  (38, 38),
  (38, 38.5),
  (39, 35.5),
  (39, 36),
  (39, 36.5),
  (39, 37.5),
  (39, 38),
  (39, 38.5),
  (40, 35.5),
  (40, 37.5),
  (40, 38),
  (40, 40);
-- insert supplier detail --
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
(4, 1, 195500000),
(4, 3, 51076500),
(4, 5, 2881500),
(4, 7, 5431500),
(4, 9, 2201500),
(4, 11, 4156500),
(4, 13, 3816500),
(4, 15, 2881500),
(4, 17, 6715000),
(4, 19, 9086500),
(4, 21, 1275000),
(4, 23, 2116500),
(4, 25, 1181500),
(4, 27, 1521500),
(4, 29, 1351500),
(4, 31, 3391500),
(4, 33, 1096500),
(4, 35, 1946500),
(4, 37, 1776500),
(4, 39, 2626500);

-- insert data imageProducts--
INSERT INTO imageProducts (idProduct, image)
VALUES (1, './image/products/1.webp'),
  (1, './image/products/1-1.webp'),
  (1, './image/products/1-2.webp'),
  (1, './image/products/1-3.webp'),
  (1, './image/products/1-4.webp'),
  (2, './image/products/2.webp'),
  (2, './image/products/2-1.webp'),
  (2, './image/products/2-2.webp'),
  (2, './image/products/2-3.webp'),
  (3, './image/products/3.webp'),
  (3, './image/products/3-1.webp'),
  (3, './image/products/3-2.webp'),
  (3, './image/products/3-3.webp'),
  (3, './image/products/3-4.webp'),
  (3, './image/products/3-5.webp'),
  (4, './image/products/4.webp'),
  (4, './image/products/4-1.webp'),
  (4, './image/products/4-2.webp'),
  (4, './image/products/4-3.webp'),
  (4, './image/products/4-4.webp'),
  (4, './image/products/4-5.webp'),
  (5, './image/products/5.webp'),
  (5, './image/products/5-1.webp'),
  (5, './image/products/5-2.webp'),
  (5, './image/products/5-3.webp'),
  (5, './image/products/5-4.webp'),
  (5, './image/products/5-5.webp'),
  (6, './image/products/6.webp'),
  (6, './image/products/6-1.webp'),
  (6, './image/products/6-2.webp'),
  (6, './image/products/6-3.webp'),
  (6, './image/products/6-4.webp'),
  (6, './image/products/6-5.webp'),
  (7, './image/products/7.webp'),
  (7, './image/products/7-1.webp'),
  (7, './image/products/7-2.webp'),
  (7, './image/products/7-3.webp'),
  (7, './image/products/7-4.webp'),
  (7, './image/products/7-5.webp'),
  (8, './image/products/8.webp'),
  (8, './image/products/8-1.webp'),
  (8, './image/products/8-2.webp'),
  (8, './image/products/8-3.webp'),
  (8, './image/products/8-4.webp'),
  (9, './image/products/9.jpg'),
  (9, './image/products/9-1.webp'),
  (9, './image/products/9-2.webp'),
  (9, './image/products/9-3.webp'),
  (9, './image/products/9-4.webp'),
  (10, './image/products/10.webp'),
  (10, './image/products/10-1.webp'),
  (10, './image/products/10-2.webp'),
  (10, './image/products/10-3.webp'),
  (10, './image/products/10-4.webp'),
  (11, './image/products/11.webp'),
  (11, './image/products/11-1.webp'),
  (11, './image/products/11-2.webp'),
  (11, './image/products/11-3.webp'),
  (11, './image/products/11-4.webp'),
  (11, './image/products/11-5.webp'),
  (12, './image/products/12.webp'),
  (12, './image/products/12-1.webp'),
  (12, './image/products/12-2.webp'),
  (12, './image/products/12-3.webp'),
  (12, './image/products/12-4.webp'),
  (13, './image/products/13.webp'),
  (13, './image/products/13-1.webp'),
  (13, './image/products/13-2.webp'),
  (13, './image/products/13-3.webp'),
  (13, './image/products/13-4.webp'),
  (14, './image/products/14.webp'),
  (14, './image/products/14-1.webp'),
  (14, './image/products/14-2.webp'),
  (14, './image/products/14-3.webp'),
  (14, './image/products/14-4.webp'),
  (15, './image/products/15.webp'),
  (15, './image/products/15-1.webp'),
  (15, './image/products/15-2.webp'),
  (15, './image/products/15-3.webp'),
  (15, './image/products/15-4.webp'),
  (16, './image/products/16.webp'),
  (16, './image/products/16-1.webp'),
  (16, './image/products/16-2.webp'),
  (16, './image/products/16-3.webp'),
  (16, './image/products/16-4.webp'),
  (17, './image/products/17.webp'),
  (17, './image/products/17-1.webp'),
  (17, './image/products/17-2.webp'),
  (17, './image/products/17-3.webp'),
  (17, './image/products/17-4.webp'),
  (18, './image/products/18.webp'),
  (18, './image/products/18-1.webp'),
  (18, './image/products/18-2.webp'),
  (18, './image/products/18-3.webp'),
  (18, './image/products/18-4.webp'),
  (19, './image/products/19.webp'),
  (19, './image/products/19-1.webp'),
  (19, './image/products/19-2.webp'),
  (19, './image/products/19-3.webp'),
  (19, './image/products/19-4.webp'),
  (20, './image/products/20.webp'),
  (20, './image/products/20-1.webp'),
  (20, './image/products/20-2.webp'),
  (20, './image/products/20-3.webp'),
  (20, './image/products/20-4.webp'),
  (21, './image/products/21.webp'),
  (21, './image/products/21-1.webp'),
  (21, './image/products/21-2.webp'),
  (22, './image/products/22.webp'),
  (22, './image/products/22-1.webp'),
  (22, './image/products/22-2.webp'),
  (22, './image/products/22-3.webp'),
  (22, './image/products/22-4.webp'),
  (23, './image/products/23.webp'),
  (23, './image/products/23-1.webp'),
  (23, './image/products/23-2.webp'),
  (23, './image/products/23-3.webp'),
  (23, './image/products/23-4.webp'),
  (24, './image/products/24.webp'),
  (24, './image/products/24-1.webp'),
  (24, './image/products/24-2.webp'),
  (24, './image/products/24-3.webp'),
  (24, './image/products/24-4.webp'),
  (25, './image/products/25.webp'),
  (25, './image/products/25-1.webp'),
  (25, './image/products/25-2.webp'),
  (25, './image/products/25-3.webp'),
  (26, './image/products/26.webp'),
  (26, './image/products/26-1.webp'),
  (26, './image/products/26-2.webp'),
  (26, './image/products/26-3.webp'),
  (26, './image/products/26-4.webp'),
  (26, './image/products/26-5.webp'),
  (27, './image/products/27.webp'),
  (27, './image/products/27-1.webp'),
  (27, './image/products/27-2.webp'),
  (27, './image/products/27-3.webp'),
  (28, './image/products/28.webp'),
  (28, './image/products/28-1.webp'),
  (28, './image/products/28-2.webp'),
  (28, './image/products/28-3.webp'),
  (28, './image/products/28-4.webp'),
  (29, './image/products/29.webp'),
  (29, './image/products/29-1.webp'),
  (29, './image/products/29-2.webp'),
  (30, './image/products/30.webp'),
  (30, './image/products/30-1.webp'),
  (30, './image/products/30-2.webp'),
  (30, './image/products/30-3.webp'),
  (30, './image/products/30-4.webp'),
  (31, './image/products/31.webp'),
  (31, './image/products/31-1.webp'),
  (31, './image/products/31-2.webp'),
  (32, './image/products/32.webp'),
  (32, './image/products/32-1.webp'),
  (32, './image/products/32-2.webp'),
  (32, './image/products/32-3.webp'),
  (32, './image/products/32-4.webp'),
  (33, './image/products/33.webp'),
  (33, './image/products/33-1.webp'),
  (33, './image/products/33-2.webp'),
  (33, './image/products/33-3.webp'),
  (34, './image/products/34.webp'),
  (34, './image/products/34-1.webp'),
  (34, './image/products/34-2.webp'),
  (35, './image/products/35.webp'),
  (35, './image/products/35-1.webp'),
  (35, './image/products/35-2.webp'),
  (35, './image/products/35-3.webp'),
  (36, './image/products/36.webp'),
  (36, './image/products/36-1.webp'),
  (36, './image/products/36-2.webp'),
  (36, './image/products/36-3.webp'),
  (37, './image/products/37.webp'),
  (37, './image/products/37-1.webp'),
  (37, './image/products/37-2.webp'),
  (37, './image/products/37-3.webp'),
  (37, './image/products/37-4.webp'),
  (38, './image/products/38.webp'),
  (38, './image/products/38-1.webp'),
  (38, './image/products/38-2.webp'),
  (38, './image/products/38-3.webp'),
  (39, './image/products/39.webp'),
  (39, './image/products/39-1.webp'),
  (39, './image/products/39-2.webp'),
  (39, './image/products/39-3.webp'),
  (39, './image/products/39-4.webp'),
  (40, './image/products/40.webp'),
  (40, './image/products/40-1.webp'),
  (40, './image/products/40-2.webp');
UPDATE sizeProducts
SET quantityRemain = 100;

INSERT INTO users (idRole, users.fullName, users.phoneNumber, users.username, users.`password`)
VALUES (2, "admin", "0123456789", "admin123", "$2y$10$bgyVh0xTbFU8kFRVan1AK.lh03ISwS53j0162crPEby.Y90k85CUC");

INSERT INTO suppliers (nameSupplier, phoneNumber, email,addressSupplier)
VALUES ('Golden Road Fashion', "0123456789", "goldenroadfashion@gmail.com", "36 Phan Huy Ich P15 QTanBinh TP Ho Chi Minh"),
('Supersports Vietnam', "02466892228", "ce@supersports.com.vn", "TTTM Lotte Mall Tây Hồ, Hà Nội"),
('The Fire Monkey', "0983151780", "tfm3017@gmail.com", "24 khối 1B, Đông Anh, Hà Nội"),
('G-Lab', "0945378809", "glabvn@gmail.com", "135/58 Trần Hưng Đạo, Phường Cầu Ông Lãnh, Quận 1, TP. Hồ Chí Minh");