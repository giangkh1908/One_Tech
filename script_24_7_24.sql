-- Set the database context

-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS Project1;
CREATE DATABASE Project1;
USE Project1;

-- Create ACCOUNT TABLE
CREATE TABLE ACCOUNT (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NULL,
    auth_method VARCHAR(50) DEFAULT 'local',
    role VARCHAR(10) NOT NULL DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL,
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    lastLogin DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(255) NULL DEFAULT 'Active'
    
);
-- Create PROFILE TABLE
CREATE TABLE PROFILE (
    userId INT PRIMARY KEY,
    fullName VARCHAR(255) NULL,
    phoneNumber Char(10),
    linkAvatar VARCHAR(255) NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL,
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    FOREIGN KEY (userId) REFERENCES ACCOUNT(id)
);
DROP TRIGGER IF EXISTS before_status_update;
DELIMITER //
CREATE TRIGGER before_status_update
BEFORE UPDATE ON account
FOR EACH ROW
BEGIN
  IF NEW.username = 'admin' AND NEW.status <> OLD.status THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Updating the status of this account is not allowed';
  END IF;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE PopulateAccountTable()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE username_prefix VARCHAR(255) DEFAULT 'user';
    DECLARE email_domain VARCHAR(255) DEFAULT '@example.com';
    DECLARE password_prefix VARCHAR(255) DEFAULT 'password';

    WHILE i <= 101 DO
        INSERT INTO ACCOUNT (username, email, password, auth_method, role, created_by, isDelete, deletedBy, status)
        VALUES (
            CONCAT(username_prefix, i),
            CONCAT(username_prefix, i, email_domain),
           'WrgImQa07PqRqVB/zPMXZplKZzU=',
            'local',
            'user',
            NULL,
            0,
            NULL,
            'Active'
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL PopulateAccountTable();
DELIMITER //

CREATE PROCEDURE PopulateProfileTable()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE name_prefix VARCHAR(255) DEFAULT 'Full Name ';
    DECLARE avatar_prefix VARCHAR(255) DEFAULT 'http://avatar.example.com/';
    DECLARE phone_number VARCHAR(20);


    WHILE i <= 101 DO
        SET phone_number = CONCAT(
            CASE FLOOR(1 + RAND() * 5)
                WHEN 1 THEN '093'
                WHEN 2 THEN '096'
                WHEN 3 THEN '097'
                WHEN 4 THEN '098'
                ELSE '086'
            END,
            LPAD(i, 7, '0')
        );
        INSERT INTO PROFILE (userId, fullName, phoneNumber, linkAvatar, created_by, isDelete, deletedBy)
        VALUES (
            i,
            CONCAT(name_prefix, i),
            phone_number,
            CONCAT(avatar_prefix, i, '.png'),
            NULL,
            0,
            NULL
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL PopulateProfileTable();

update account set role = 'admin', username='admin' where id =  LAST_INSERT_ID();

-- Create CATEGORY TABLE
CREATE TABLE CATEGORY (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL,
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    status VARCHAR(255) NULL default 'Active'
);

-- Create PRODUCT TABLE
CREATE TABLE PRODUCT (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    categoryID INT NULL,
    price DECIMAL(18, 2) NOT NULL,
    image VARCHAR(255) NULL,
    quantity INT NOT NULL,
    description VARCHAR(255) NULL,
    discount DECIMAL(18, 2) NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL,
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    status VARCHAR(255) default 'Active',
    FOREIGN KEY (categoryID) REFERENCES CATEGORY(id)
);

-- Create CART TABLE
CREATE TABLE CART (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NULL,
    productID VARCHAR(255) NULL,
    quantity INT NOT NULL,
    transactionCode Nvarchar(255) null,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL,
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    status VARCHAR(255) NULL,
    FOREIGN KEY (userID) REFERENCES ACCOUNT(id),
    FOREIGN KEY (productID) REFERENCES PRODUCT(id)
);

-- Create TRANSACTION TABLE
CREATE TABLE `TRANSACTION` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NULL,
    beforeTransactMoney int NOT NULL,
    afterTransactMoney int NOT NULL,
     description Nvarchar(255),
      transaction_type ENUM('plus', 'minus') NOT NULL,
    transactionCode Nvarchar(255) not null unique,
    cartID INT NULL,
    amount int NOT NULL, -- total
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL default 'user',
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    status VARCHAR(255) NULL,
    FOREIGN KEY (userID) REFERENCES ACCOUNT(id),
    FOREIGN KEY (cartID) REFERENCES CART(id)
);
-- Create Repository TABLE
CREATE TABLE Repository (
    id INT PRIMARY KEY AUTO_INCREMENT,
	productID VARCHAR(255) ,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    code VARCHAR(255) NOT NULL UNIQUE,
	seri_number CHAR(10) NOT NULL UNIQUE,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL,
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    status VARCHAR(255) Not NULL default 'Active',
    FOREIGN KEY (productID) REFERENCES product(id)
);
-- Create BILL TABLE
CREATE TABLE BILL (
    id INT PRIMARY KEY AUTO_INCREMENT,
    repositoryId int not null,
    transactionCode Nvarchar(255) not null,
    productId VARCHAR(255) NOT NULL,
    code VARCHAR(255) NOT NULL,
      seri_number CHAR(10) NOT NULL ,
    quantity INT NOT NULL default 1,
    price DECIMAL(18, 2) NOT NULL,
    total DECIMAL(18, 2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    created_by VARCHAR(255) NULL,
    isDelete TINYINT(1) DEFAULT 0,
    deletedBy VARCHAR(255) NULL,
    deletedAt DATETIME NULL,
    status VARCHAR(255) NULL,
     FOREIGN KEY (repositoryId) REFERENCES Repository(id),
      FOREIGN KEY (productId) REFERENCES product(id)
);


CREATE TABLE Post (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    coverImg VARCHAR(255) NOT NULL,
    img1 VARCHAR(255) DEFAULT NULL,
    img2 VARCHAR(255) DEFAULT NULL,
    para1 TEXT NOT NULL,
    para2 TEXT DEFAULT NULL,
    quote TEXT DEFAULT NULL,
    quote_author VARCHAR(255) DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(255) DEFAULT 'Active'
);
-- Insert data into CATEGORY table
SET SQL_SAFE_UPDATES = 1;
INSERT INTO CATEGORY (name, created_at, created_by, status)
VALUES
    ('Zing', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
    ('Garena', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
    ('VCoin', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
    ('Funcard', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
    ('GATE', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
    ('Viettel', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
    ('Mobifone', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
    ('Vinaphone', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
	('Shopee', CURRENT_TIMESTAMP, 'MinhT1311', 'Active'),
	('Highlands', CURRENT_TIMESTAMP, 'MinhT1311', 'Active');


-- Insert data into PRODUCT table
INSERT INTO PRODUCT (id, name, categoryID, price, image, quantity, description, discount, created_at, created_by) 
VALUES 
('zing50', 'Zing 50k', 1, 50000, 'images/card/zing50.jpg', 20, 'Zing Card 50.000 VND', 15, CURRENT_TIMESTAMP, 'MinhT1311'),
('zing100', 'Zing 100k', 1, 100000, 'images/card/zing100.jpg', 3, 'Zing Card 100.000 VND', 2, CURRENT_TIMESTAMP, 'MinhT1311'),
('zing200', 'Zing 200k', 1, 200000, 'images/card/zing200.jpg', 3, 'Zing Card 200.000 VND', 2, CURRENT_TIMESTAMP, 'MinhT1311'),
('zing500', 'Zing 500k', 1, 500000, 'images/card/zing500.jpg', 3, 'Zing Card 500.000 VND', 2, CURRENT_TIMESTAMP, 'MinhT1311'),
('zing1000', 'Zing 1M', 1, 1000000, 'images/card/zing1000.jpg', 3, 'Zing Card 1.000.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),

('garena50', 'Garena 50k', 2, 50000, 'images/card/garena50.jpg', 3, 'Garena Card 50.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('garena100', 'Garena 100k', 2, 100000, 'images/card/garena100.jpg', 3, 'Garena Card 100.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('garena200', 'Garena 200k', 2, 200000, 'images/card/garena200.jpg', 3, 'Garena Card 200.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('garena500', 'Garena 500k', 2, 500000, 'images/card/garena500.jpg', 3, 'Garena Card 500.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),

('vcoin50', 'VCoin 50k', 3, 50000, 'images/card/vcoin50.jpg', 3, 'VCoin Card 50.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('vcoin100', 'VCoin 100k', 3, 100000, 'images/card/vcoin100.jpg', 3, 'VCoin Card 100.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('vcoin200', 'VCoin 200k', 3, 200000, 'images/card/vcoin200.jpg', 3, 'VCoin Card 200.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('vcoin500', 'VCoin 500k', 3, 500000, 'images/card/vcoin500.jpg', 3, 'VCoin Card 500.000 VND', 15, CURRENT_TIMESTAMP, 'MinhT1311'),
('vcoin1000', 'VCoin 1M', 3, 1000000, 'images/card/vcoin1000.jpg', 3, 'VCoin Card 1.000.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('vcoin2000', 'VCoin 2M', 3, 2000000, 'images/card/vcoin2000.jpg', 3, 'VCoin Card 2.000.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('vcoin5000', 'VCoin 5M', 3, 5000000, 'images/card/vcoin5000.jpg', 3, 'VCoin Card 5.000.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),

('funcard50', 'Funcard 50k', 4, 50000, 'images/card/funcard50.jpg', 3, 'Funcard Card 50.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('funcard100', 'Funcard 100k', 4, 100000, 'images/card/funcard100.jpg', 3, 'Funcard Card 100.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('funcard200', 'Funcard 200k', 4, 200000, 'images/card/funcard200.jpg', 3, 'Funcard Card 200.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('funcard500', 'Funcard 500k', 4, 500000, 'images/card/funcard500.jpg', 3, 'Funcard Card 500.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('funcard1000', 'Funcard 1M', 4, 1000000, 'images/card/funcard1000.jpg', 3, 'Funcard Card 1.000.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('funcard2000', 'Funcard 2M', 4, 2000000, 'images/card/funcard2000.jpg', 3, 'Funcard Card 2.000.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),

('gate50', 'GATE 50k', 5, 50000, 'images/card/gate50.jpg', 3, 'VCoin Card 50.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('gate100', 'GATE 100k', 5, 100000, 'images/card/gate100.jpg', 3, 'VCoin Card 100.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('gate200', 'GATE 200k', 5, 200000, 'images/card/gate200.jpg', 3, 'VCoin Card 200.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('gate500', 'GATE 500k', 5, 500000, 'images/card/gate500.jpg', 3, 'VCoin Card 500.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('gate1000', 'GATE 1M', 5, 1000000, 'images/card/gate1000.jpg', 3, 'VCoin Card 1.000.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('gate2000', 'GATE 2M', 5, 2000000, 'images/card/gate2000.jpg', 3, 'VCoin Card 2.000.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('gate5000', 'GATE 5M', 5, 5000000, 'images/card/gate5000.jpg', 3, 'VCoin Card 5.000.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),

('viettel50', 'Viettel 50k', 6, 50000, 'images/card/viettel50.jpg', 3, 'Viettel Card 50.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('viettel100', 'Viettel 100k', 6, 100000, 'images/card/viettel100.jpg', 3, 'Viettel Card 100.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('viettel200', 'Viettel 200k', 6, 200000, 'images/card/viettel200.jpg', 3, 'Viettel Card 200.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('viettel300', 'Viettel 300k', 6, 300000, 'images/card/viettel300.jpg', 3, 'Viettel Card 300.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('viettel500', 'Viettel 500k', 6, 500000, 'images/card/viettel500.jpg', 3, 'Viettel Card 500.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('viettel1000', 'Viettel 1M', 6, 1000000, 'images/card/viettel1000.jpg', 3, 'Viettel Card 1.000.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),

('mobi100', 'Mobifone 100k', 7, 100000, 'images/card/mobi100.jpg', 3, 'Mobifone Card 100.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('mobi200', 'Mobifone 200k', 7, 200000, 'images/card/mobi200.jpg', 3, 'Mobifone Card 200.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('mobi500', 'Mobifone 500k', 7, 500000, 'images/card/mobi500.jpg', 3, 'Mobifone Card 500.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),

('vina10', 'Vinaphone 10k', 8, 10000, 'images/card/vina10.jpg', 3, 'Vinaphone Card 10.000 VND', 2, CURRENT_TIMESTAMP, 'MinhT1311'),
('vina20', 'Vinaphone 20k', 8, 20000, 'images/card/vina20.jpg', 20, 'Vinaphone Card 20.000 VND', 2, CURRENT_TIMESTAMP, 'MinhT1311'),
('vina50', 'Vinaphone 50k', 8, 500000, 'images/card/vina50.jpg', 3, 'Vinaphone Card 500.00 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('vina100', 'Vinaphone 100k', 8, 100000, 'images/card/vina100.jpg', 3, 'Vinaphone Card 100.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('vina200', 'Vinaphone 200k', 8, 200000, 'images/card/vina200.jpg', 3, 'Vinaphone Card 200.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('vina500', 'Vinaphone 500k', 8, 500000, 'images/card/vina500.jpg', 3, 'Vinaphone Card 500.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('vina1000', 'Vinaphone 1M', 8, 1000000, 'images/card/vina1000.jpg', 3, 'Vinaphone Card 10.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),

('shopee10', 'Shopee 10k', 9, 10000, 'images/card/shopee10.jpg', 3, 'Shopee Discount 10.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('shopee50', 'Shopee 50k', 9, 50000, 'images/card/shopee50.jpg', 3, 'Shopee Discount 50.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('shopee100', 'Shopee 100k', 9, 100000, 'images/card/shopee100.jpg', 3, 'Shopee Discount 100.000 VND', 5, CURRENT_TIMESTAMP, 'MinhT1311'),
('shopeefreeship', 'Shopee Free Shipping', 9, 5000, 'images/card/shopeefreeship.jpg', 3, 'Free Shipping for products under 50.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('shopeextra', 'Shopee Free Shipping Xtra', 9, 5000, 'images/card/shopeextra.jpg', 3, 'Free Shipping Xtra for products over 50.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),

('highlands20', 'Highlands 20k', 10, 20000, 'images/card/highlands20.jpg', 3, 'Highlands Card 20.000 VND', 15, CURRENT_TIMESTAMP, 'MinhT1311'),
('highlands50', 'Highlands 50k', 10, 50000, 'images/card/highlands50.jpg', 3, 'Highlands Card 50.000 VND', 10, CURRENT_TIMESTAMP, 'MinhT1311'),
('highlands100', 'Highlands 100k', 10, 100000, 'images/card/highlands100.jpg', 3, 'Highlands Card 100.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('highlands200', 'Highlands 200k', 10, 200000, 'images/card/highlands200.jpg', 3, 'Highlands Card 200.000 VND', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('highlandsget1', 'Highlands Buy 2 Get 1', 10, 50000, 'images/card/highlandsget1.jpg', 3, 'Buy 2 drinks from Highlands and get a third drink for free!', 0, CURRENT_TIMESTAMP, 'MinhT1311'),
('highlandspay1', 'Highlands Buy 2 Pay 1', 10, 30000, 'images/card/highlandspay1.jpg', 3, 'Buy 2 drinks from Highlands and pay the price of 1!', 0, CURRENT_TIMESTAMP, 'MinhT1311');




SET SQL_SAFE_UPDATES = 0;

DELIMITER $$

CREATE TRIGGER after_category_update
AFTER UPDATE ON Category
FOR EACH ROW
BEGIN
    IF NEW.status = 'Archived' THEN
        UPDATE Product
        SET status = 'Archived'
        WHERE categoryID = NEW.id;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER before_product_update
BEFORE UPDATE ON Product
FOR EACH ROW
BEGIN
    DECLARE categoryStatus VARCHAR(20);
    
    -- Get the category status
    SELECT status INTO categoryStatus FROM Category WHERE id = NEW.categoryID;
    
    -- Check if the new status is 'Unarchived' and category status is 'Archived'
    IF NEW.status = 'Active' AND categoryStatus = 'Archived' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot set product status to Unarchived while category is Archived';
    END IF;
END$$

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_category_insert
BEFORE INSERT ON category
FOR EACH ROW
BEGIN
    DECLARE category_count INT;
    SELECT COUNT(*) INTO category_count FROM category WHERE name = NEW.name;
    IF category_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate category name not allowed';
    END IF;
END;
//
DELIMITER ;


DELIMITER //

CREATE TRIGGER before_product_insert
BEFORE INSERT ON product
FOR EACH ROW
BEGIN
    DECLARE product_count INT;
    SELECT COUNT(*) INTO product_count FROM product WHERE id = NEW.id;
    IF category_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate product name not allowed';
    END IF;
END;
//
DELIMITER ;
INSERT INTO `Transaction` 
(transaction_type, amount, beforeTransactMoney, afterTransactMoney, userID, created_at, description, transactionCode, status) 
VALUES 
('plus', 1000, 0, 1000, 1, DATE_ADD(CURDATE(), INTERVAL -365 DAY), 'Test transaction 1', 'TXN12345_1', 'Processed'),
('plus', 200, 0, 200, 2, DATE_ADD(CURDATE(), INTERVAL -348 DAY), 'Test transaction 2', 'TXN12345_2', 'Processed'),
('plus', 300, 1000, 1300, 1, DATE_ADD(CURDATE(), INTERVAL -331 DAY), 'Test transaction 3', 'TXN12345_3', 'Processed'),
('plus', 400, 200, 600, 2, DATE_ADD(CURDATE(), INTERVAL -314 DAY), 'Test transaction 4', 'TXN12345_4', 'Processed'),
('plus', 500, 1300, 1800, 1, DATE_ADD(CURDATE(), INTERVAL -297 DAY), 'Test transaction 5', 'TXN12345_5' , 'Processed'),
('plus', 600, 600, 1200, 2, DATE_ADD(CURDATE(), INTERVAL -280 DAY), 'Test transaction 6', 'TXN12345_6', 'Processed'),
('plus', 700, 1800, 2500, 1, DATE_ADD(CURDATE(), INTERVAL -263 DAY), 'Test transaction 7', 'TXN12345_7', 'Processed'),
('plus', 800, 1200, 2000, 2, DATE_ADD(CURDATE(), INTERVAL -246 DAY), 'Test transaction 8', 'TXN12345_8', 'Processed'),
('plus', 900, 2500, 3400, 1, DATE_ADD(CURDATE(), INTERVAL -229 DAY), 'Test transaction 9', 'TXN12345_9', 'Processed'),
('plus', 1000, 2000, 3000, 2, DATE_ADD(CURDATE(), INTERVAL -212 DAY), 'Test transaction 10', 'TXN12345_10', 'Processed'),
('plus', 1100, 3400, 4500, 1, DATE_ADD(CURDATE(), INTERVAL -195 DAY), 'Test transaction 11', 'TXN12345_11', 'Processed'),
('plus', 1200, 3000, 4200, 2, DATE_ADD(CURDATE(), INTERVAL -178 DAY), 'Test transaction 12', 'TXN12345_12', 'Processed'),
('plus', 1300, 4500, 5800, 1, DATE_ADD(CURDATE(), INTERVAL -161 DAY), 'Test transaction 13', 'TXN12345_13', 'Processed'),
('plus', 1400, 4200, 5600, 2, DATE_ADD(CURDATE(), INTERVAL -144 DAY), 'Test transaction 14', 'TXN12345_14', 'Processed'),
('plus', 1500, 5800, 7300, 1, DATE_ADD(CURDATE(), INTERVAL -127 DAY), 'Test transaction 15', 'TXN12345_15', 'Processed'),
('plus', 1600, 5600, 7200, 2, DATE_ADD(CURDATE(), INTERVAL -110 DAY), 'Test transaction 16', 'TXN12345_16', 'Processed'),
('plus', 1700, 7300, 9000, 1, DATE_ADD(CURDATE(), INTERVAL -93 DAY), 'Test transaction 17', 'TXN12345_17', 'Processed'),
('plus', 1800, 7200, 9000, 2, DATE_ADD(CURDATE(), INTERVAL -76 DAY), 'Test transaction 18', 'TXN12345_18', 'Processed'),
('plus', 1900, 9000, 10900, 1, DATE_ADD(CURDATE(), INTERVAL -59 DAY), 'Test transaction 19', 'TXN12345_19', 'Processed'),
('plus', 2000, 9000, 11000, 2, DATE_ADD(CURDATE(), INTERVAL -42 DAY), 'Test transaction 20', 'TXN12345_20', 'Processed'),
('plus', 10000000, 10900, 10010900, 1, DATE_ADD(CURDATE(), INTERVAL -40 DAY), 'Test transaction 21', 'TXN12345_21', 'Processed'),
('plus', 10000000, 11000, 10011000, 2, DATE_ADD(CURDATE(), INTERVAL -39 DAY), 'Test transaction 22', 'TXN12345_22', 'Processed'),
('plus', 100000000, 0, 100000000, (SELECT id FROM account WHERE role = 'admin'), DATE_ADD(CURDATE(), INTERVAL -38 DAY), 'Test transaction 23', 'TXN12345_23', 'Processed')
;

INSERT INTO Post (title, coverImg, img1, img2, para1, para2, quote, quote_author, status)
VALUES 
('Introduction to Phone Cards', 'images/cover1.jpg', NULL, NULL, 'Phone cards are a convenient product that allows users to top up their phone accounts. With the advancement of technology, phone cards are not only used for recharging but also for many other purposes.', 'Besides recharging, phone cards can also be used to purchase online services, pay bills, and many other utilities.', 'Phone cards are an indispensable part of modern life.', 'John Doe', 'Active'),


('Attractive Offers from Shopping Vouchers', 'images/cover2.jpg', 'images/img2_1.jpg', 'images/img2_2.jpg', 
'Shopping vouchers are a popular form of promotion that helps consumers save money on their purchases. They can be used in various stores and online platforms.', 
'In addition to discounts, shopping vouchers often come with exclusive deals and benefits, making shopping more enjoyable.', 
NULL, NULL, 'Active'),

('The Benefits of Using Phone Cards', 'images/cover3.jpg', 'images/img3_1.jpg', 'images/img3_2.jpg', 
'Using phone cards offers numerous benefits, including convenience, flexibility, and security. They are easy to purchase and use, making them a preferred choice for many.', 
'Phone cards also allow users to control their spending and avoid unexpected charges, providing peace of mind.', 
'Phone cards are a reliable and cost-effective solution for managing your phone expenses.', 'Alice Johnson', 'Active'),

('How to Redeem Your Shopping Vouchers', 'images/cover4.jpg', 'images/img4_1.jpg', 'images/img4_2.jpg', 
'Redeeming shopping vouchers is a simple process. Just follow the instructions provided with the voucher, and you can enjoy discounts and special offers.', 
'Most vouchers can be redeemed both in-store and online, giving you the flexibility to shop the way you prefer.', 
'Make the most of your shopping experience by using vouchers.', 'Michael Brown', 'Active');


DELIMITER //

CREATE PROCEDURE InsertRepositoryRecords()
BEGIN
    DECLARE v_productID VARCHAR(255);
    DECLARE v_quantity INT;
    DECLARE v_counter INT;
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR 
        SELECT id, quantity FROM product WHERE id IN ('zing100', 'zing1000', 'zing200', 'zing50', 'zing500', 
                                                                    'garena100', 'garena200', 'garena50', 'garena500', 
                                                                    'vcoin100', 'vcoin1000', 'vcoin200', 'vcoin2000', 
                                                                    'vcoin50', 'vcoin500', 'vcoin5000', 
                                                                    'funcard100', 'funcard1000', 'funcard200', 'funcard2000', 
                                                                    'funcard50', 'funcard500', 
                                                                    'gate100', 'gate1000', 'gate200', 'gate2000', 
                                                                    'gate50', 'gate500', 'gate5000', 
                                                                    'viettel100', 'viettel1000', 'viettel200', 'viettel300', 
                                                                    'viettel50', 'viettel500', 
                                                                    'mobi100', 'mobi200', 'mobi500', 
                                                                    'vina10', 'vina100', 'vina1000', 'vina20', 
                                                                    'vina200', 'vina50', 'vina500', 
                                                                    'shopee10', 'shopee100', 'shopee50', 'shopeefreeship', 
                                                                    'shopeextra', 
                                                                    'highlands100', 'highlands20', 'highlands200', 
                                                                    'highlands50', 'highlandsget1', 'highlandspay1');

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_productID, v_quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET v_counter = 1;

        WHILE v_counter <= v_quantity DO
            INSERT INTO Repository (productID, code, seri_number, created_by)
            VALUES (v_productID, CONCAT('', LPAD(FLOOR(RAND() * 99999999), 10, '0')), CONCAT('', LPAD(FLOOR(RAND() * 99999999), 10, '0')), CONCAT('user', v_counter MOD 5 + 1));
            SET v_counter = v_counter + 1;
        END WHILE;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL InsertRepositoryRecords();
-- INSERT INTO Repository (productID, code, seri_number, created_by) 
-- VALUES 
-- ('funcard50', 'code123', 'SN00000001', 'admin'),
-- ('funcard50', 'code124', 'SN00000002', 'admin'),
-- ('funcard50', 'code125', 'SN00000003', 'admin');

-- Insert records into BILL table
-- INSERT INTO BILL (repositoryId, transactionCode, productid, price, total, created_by) 
-- VALUES 
-- ((SELECT id FROM Repository WHERE code = 'code123'), 'TXN001', 'funcard50', 100.00, 100.00, 'user1'),
-- ((SELECT id FROM Repository WHERE code = 'code124'), 'TXN002', 'funcard50', 200.00, 200.00, 'user1'),
-- ((SELECT id FROM Repository WHERE code = 'code125'), 'TXN003', 'funcard50', 150.00, 150.00, 'user1');

-- DELIMITER //

-- CREATE TRIGGER archive_product_if_quantity_zero
-- BEFORE UPDATE ON PRODUCT
-- FOR EACH ROW
-- BEGIN
--     IF NEW.quantity = 0 THEN
--         SET NEW.status = 'Archived';
--     END IF;
-- END;
-- //

-- DELIMITER ;

-- DELIMITER //

-- CREATE TRIGGER activate_product_if_quantity_positive
-- BEFORE UPDATE ON PRODUCT
-- FOR EACH ROW
-- BEGIN
--     IF NEW.quantity > 0 THEN
--         SET NEW.status = 'Active';
--     ELSEIF NEW.quantity = 0 THEN
--         SET NEW.status = 'Archived';
--     END IF;
-- END;
-- //

-- DELIMITER ;
DELIMITER $$

CREATE TRIGGER after_product_update
AFTER UPDATE ON PRODUCT
FOR EACH ROW
BEGIN
    DECLARE cart_qty INT;
    DECLARE cart_id INT;
    DECLARE done INT DEFAULT 0;
    DECLARE cart_cursor CURSOR FOR 
        SELECT id, quantity FROM CART WHERE productID = NEW.id AND status = 'Active';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cart_cursor;
    
    read_loop: LOOP
        FETCH cart_cursor INTO cart_id, cart_qty;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Check if the quantity in the cart is greater than the available product quantity or the product quantity is zero
        IF cart_qty > NEW.quantity OR NEW.quantity = 0 THEN
            DELETE FROM CART WHERE id = cart_id;
        END IF;
    END LOOP;

    CLOSE cart_cursor;
END $$

DELIMITER ;
