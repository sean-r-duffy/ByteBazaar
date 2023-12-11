-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema byte_bazaar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema byte_bazaar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `byte_bazaar` DEFAULT CHARACTER SET utf8 ;
USE `byte_bazaar` ;

-- -----------------------------------------------------
-- Table `byte_bazaar`.`buyer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`buyer` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`buyer` (
  `username` VARCHAR(40) NOT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `password` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`address` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `buyer_username` VARCHAR(40) NULL DEFAULT NULL,
  `street` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL,
  `zip` INT NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `buyer_username` (`buyer_username` ASC) VISIBLE,
  CONSTRAINT `address_ibfk_1`
    FOREIGN KEY (`buyer_username`)
    REFERENCES `byte_bazaar`.`buyer` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`category` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`product` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `category_id` INT NULL DEFAULT NULL,
  `price` FLOAT NULL DEFAULT NULL,
  `inventory` INT NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  CONSTRAINT `product_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `byte_bazaar`.`category` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`influencer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`influencer` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`influencer` (
  `influencer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `username` VARCHAR(40) NULL DEFAULT NULL,
  `password` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`influencer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`platform` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`platform` (
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`campaign`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`campaign` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`campaign` (
  `campaign_id` VARCHAR(20) NOT NULL,
  `product_id` INT NULL DEFAULT NULL,
  `influencer_id` INT NULL DEFAULT NULL,
  `url` VARCHAR(100) NULL DEFAULT NULL,
  `platform_name` VARCHAR(50) NULL DEFAULT NULL,
  `units_sold` INT NULL DEFAULT NULL,
  PRIMARY KEY (`campaign_id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  INDEX `influencer_id` (`influencer_id` ASC) VISIBLE,
  INDEX `platform_name` (`platform_name` ASC) VISIBLE,
  CONSTRAINT `campaign_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `byte_bazaar`.`product` (`product_id`),
  CONSTRAINT `campaign_ibfk_2`
    FOREIGN KEY (`influencer_id`)
    REFERENCES `byte_bazaar`.`influencer` (`influencer_id`),
  CONSTRAINT `campaign_ibfk_3`
    FOREIGN KEY (`platform_name`)
    REFERENCES `byte_bazaar`.`platform` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`cart` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`cart` (
  `buyer_username` VARCHAR(40) NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`buyer_username`, `product_id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `cart_ibfk_1`
    FOREIGN KEY (`buyer_username`)
    REFERENCES `byte_bazaar`.`buyer` (`username`),
  CONSTRAINT `cart_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `byte_bazaar`.`product` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`image` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`image` (
  `url` VARCHAR(200) NOT NULL,
  `product_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`url`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `image_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `byte_bazaar`.`product` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`payment` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`payment` (
  `card_number` BIGINT NOT NULL AUTO_INCREMENT,
  `buyer_username` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`card_number`),
  INDEX `buyer_username` (`buyer_username` ASC) VISIBLE,
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`buyer_username`)
    REFERENCES `byte_bazaar`.`buyer` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`review` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`review` (
  `buyer_username` VARCHAR(40) NOT NULL,
  `product_id` INT NOT NULL,
  `rating` INT NULL DEFAULT NULL,
  `text` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`buyer_username`, `product_id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `review_ibfk_1`
    FOREIGN KEY (`buyer_username`)
    REFERENCES `byte_bazaar`.`buyer` (`username`),
  CONSTRAINT `review_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `byte_bazaar`.`product` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`shipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`shipment` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`shipment` (
  `shipment_id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NULL DEFAULT NULL,
  `buyer_username` VARCHAR(40) NULL DEFAULT NULL,
  `card_number` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`shipment_id`),
  INDEX `address_id` (`address_id` ASC) VISIBLE,
  INDEX `buyer_username` (`buyer_username` ASC) VISIBLE,
  INDEX `card_number` (`card_number` ASC) VISIBLE,
  CONSTRAINT `shipment_ibfk_1`
    FOREIGN KEY (`address_id`)
    REFERENCES `byte_bazaar`.`address` (`address_id`),
  CONSTRAINT `shipment_ibfk_2`
    FOREIGN KEY (`buyer_username`)
    REFERENCES `byte_bazaar`.`buyer` (`username`),
  CONSTRAINT `shipment_ibfk_3`
    FOREIGN KEY (`card_number`)
    REFERENCES `byte_bazaar`.`payment` (`card_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`sale` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`sale` (
  `sale_id` INT NOT NULL AUTO_INCREMENT,
  `shipment_id` INT NULL DEFAULT NULL,
  `product_id` INT NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `datetime` DATETIME NULL DEFAULT NULL,
  `promo_code` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  INDEX `shipment_id` (`shipment_id` ASC) VISIBLE,
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  INDEX `promo_code` (`promo_code` ASC) VISIBLE,
  CONSTRAINT `sale_ibfk_1`
    FOREIGN KEY (`shipment_id`)
    REFERENCES `byte_bazaar`.`shipment` (`shipment_id`),
  CONSTRAINT `sale_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `byte_bazaar`.`product` (`product_id`),
  CONSTRAINT `sale_ibfk_3`
    FOREIGN KEY (`promo_code`)
    REFERENCES `byte_bazaar`.`campaign` (`campaign_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`seller` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`seller` (
  `seller_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `username` VARCHAR(40) NULL DEFAULT NULL,
  `password` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`seller_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`sells`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`sells` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`sells` (
  `seller_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`seller_id`, `product_id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `sells_ibfk_1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `byte_bazaar`.`seller` (`seller_id`),
  CONSTRAINT `sells_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `byte_bazaar`.`product` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `byte_bazaar` ;

-- -----------------------------------------------------
-- Placeholder table for view `byte_bazaar`.`all_account_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byte_bazaar`.`all_account_info` (`buyer_name` INT, `buyer_username` INT, `buyer_password` INT);

-- -----------------------------------------------------
-- Placeholder table for view `byte_bazaar`.`sales_by_seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byte_bazaar`.`sales_by_seller` (`seller_name` INT, `num_sales` INT);

-- -----------------------------------------------------
-- Placeholder table for view `byte_bazaar`.`sold_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byte_bazaar`.`sold_to` (`seller_id` INT, `seller_name` INT, `product_id` INT, `buyer_username` INT, `sale_id` INT, `sale_date` INT);

-- -----------------------------------------------------
-- procedure add_to_cart
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP procedure IF EXISTS `byte_bazaar`.`add_to_cart`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` PROCEDURE `add_to_cart`(
    IN p_product_id INT, 
    IN p_username VARCHAR(50),
    IN p_quantity INT
)
BEGIN
	INSERT INTO cart
	VALUES (p_username, p_product_id, p_quantity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function avg_rating
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP function IF EXISTS `byte_bazaar`.`avg_rating`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` FUNCTION `avg_rating`(
	p_product_id INT
) RETURNS decimal(20,2)
    READS SQL DATA
BEGIN 
	DECLARE avg_rating DECIMAL(20, 2);

	SELECT AVG(r.rating) INTO avg_rating
	FROM review AS r
	GROUP BY r.product_id
    HAVING r.product_id = p_product_id;

	RETURN avg_rating;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function cart_subtotal
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP function IF EXISTS `byte_bazaar`.`cart_subtotal`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` FUNCTION `cart_subtotal`(
	p_username VARCHAR(40)
) RETURNS decimal(20,2)
    READS SQL DATA
BEGIN 
	DECLARE total_cost DECIMAL(20, 2);

	SELECT SUM(c.quantity * p.price) INTO total_cost
	FROM cart AS c
	JOIN product AS p
	ON p.product_id = c.product_id
	GROUP BY c.buyer_username
    HAVING c.buyer_username = p_username;

	RETURN total_cost;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure change_address
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP procedure IF EXISTS `byte_bazaar`.`change_address`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` PROCEDURE `change_address`(
    IN p_address_id INT, 
    IN p_street VARCHAR(50), 
    IN p_city VARCHAR(50), 
    IN p_state VARCHAR(50),
    IN p_zip INT
)
BEGIN
    UPDATE address AS a
    SET a.street = p_street, a.city = p_city, a.state = p_state, a.zip = p_zip
    WHERE address_id = p_address_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure display_reviews
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP procedure IF EXISTS `byte_bazaar`.`display_reviews`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` PROCEDURE `display_reviews`(
    IN p_product_id VARCHAR(50)
)
BEGIN
    SELECT r.buyer_username, p.name, p.price,r.rating, r.text
	FROM review AS r
	JOIN product AS p
	ON r.product_id = p.product_id
    WHERE p.product_id = p_product_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function get_inventory
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP function IF EXISTS `byte_bazaar`.`get_inventory`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` FUNCTION `get_inventory`(
	p_product_id INT
) RETURNS int
    READS SQL DATA
BEGIN 
	DECLARE product_inventory INT;

	SELECT SUM(p.inventory) INTO product_inventory
	FROM product AS p 
	WHERE p.product_id = p_product_id;

	RETURN product_inventory;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure new_buyer_or_seller
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP procedure IF EXISTS `byte_bazaar`.`new_buyer_or_seller`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` PROCEDURE `new_buyer_or_seller`(
    IN p_name VARCHAR(50), 
    IN p_username VARCHAR(40), 
    IN p_password VARCHAR(40), 
    IN p_type VARCHAR(6),
    OUT success INT
)
BEGIN
    IF p_type = 'buyer' THEN
        INSERT INTO buyer
        VALUES (p_username, p_name, p_password);
        SET success = 1;
    ELSEIF p_type = 'seller' THEN
        INSERT INTO seller
        VALUES(DEFAULT, p_name, p_username, p_password);
        SET success = 1;
    ELSE
        SET success = 0;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function revenue_by_seller
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP function IF EXISTS `byte_bazaar`.`revenue_by_seller`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` FUNCTION `revenue_by_seller`(
	p_seller_id INT
) RETURNS decimal(20,2)
    READS SQL DATA
BEGIN 
	DECLARE total_revenue DECIMAL(20, 2);

	SELECT SUM(p.price * sa.quantity) INTO total_revenue
	FROM seller AS slr
	JOIN sells AS sls
	ON slr.seller_id = sls.seller_id
	JOIN product AS p
	ON p.product_id = sls.product_id
	JOIN sale AS sa
	ON sa.product_id = p.product_id
	GROUP BY slr.seller_id
    HAVING slr.seller_id = p_seller_id;

	RETURN total_revenue;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure search_products
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP procedure IF EXISTS `byte_bazaar`.`search_products`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` PROCEDURE `search_products`(
	IN p_category_id VARCHAR(50),
    OUT num_products INT
)
BEGIN 
	DECLARE num_products_in_category INT;
    SELECT COUNT(*) INTO num_products_in_category
    FROM product AS p
    WHERE p.category_id = p_category_id;
    
	  SELECT *
    FROM product AS p
    WHERE p.category_id = p_category_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure show_prev_orders
-- -----------------------------------------------------

USE `byte_bazaar`;
DROP procedure IF EXISTS `byte_bazaar`.`show_prev_orders`;

DELIMITER $$
USE `byte_bazaar`$$
CREATE DEFINER=`user_1`@`%` PROCEDURE `show_prev_orders`(
    IN p_id VARCHAR(50), 
    IN p_type VARCHAR(6),
    OUT success INT,
    OUT error_msg VARCHAR(50)
)
BEGIN
    IF p_type = 'buyer' THEN
        SELECT b.username, p.name, p.price, sa.datetime
        FROM buyer AS b
        JOIN shipment AS sh
        ON sh.buyer_username = b.username
		    JOIN sale AS sa
        ON sa.shipment_id = sh.shipment_id
        JOIN product AS p
        ON p.product_id = sa.product_id
        WHERE b.username = p_id;
        SET success = 1;
    ELSEIF p_type = 'seller' THEN
        SELECT slr.name, p.name, p.price, sa.quantity, sa.datetime
		    FROM seller AS slr
		    JOIN sells AS sls
		    ON slr.seller_id = sls.seller_id
		    JOIN product AS p
		    ON p.product_id = sls.product_id
		    JOIN sale AS sa
		    ON p.product_id = sa.product_id
        WHERE slr.seller_id = p_id;
        SET success = 1;
    ELSE
        SET success = 0;
        SET error_msg = 'Invalid user type.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `byte_bazaar`.`all_account_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`all_account_info`;
DROP VIEW IF EXISTS `byte_bazaar`.`all_account_info` ;
USE `byte_bazaar`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`user_1`@`%` SQL SECURITY DEFINER VIEW `byte_bazaar`.`all_account_info` AS select `b`.`name` AS `buyer_name`,`b`.`username` AS `buyer_username`,`b`.`password` AS `buyer_password` from `byte_bazaar`.`buyer` `b` union select `s`.`name` AS `name`,`s`.`username` AS `username`,`s`.`password` AS `password` from `byte_bazaar`.`seller` `s`;

-- -----------------------------------------------------
-- View `byte_bazaar`.`sales_by_seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`sales_by_seller`;
DROP VIEW IF EXISTS `byte_bazaar`.`sales_by_seller` ;
USE `byte_bazaar`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`user_1`@`%` SQL SECURITY DEFINER VIEW `byte_bazaar`.`sales_by_seller` AS select `slr`.`name` AS `seller_name`,count(0) AS `num_sales` from (((`byte_bazaar`.`seller` `slr` join `byte_bazaar`.`sells` `sls` on((`slr`.`seller_id` = `sls`.`seller_id`))) join `byte_bazaar`.`product` `p` on((`p`.`product_id` = `sls`.`product_id`))) join `byte_bazaar`.`sale` `sa` on((`sa`.`product_id` = `sls`.`product_id`))) group by `slr`.`name`;

-- -----------------------------------------------------
-- View `byte_bazaar`.`sold_to`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`sold_to`;
DROP VIEW IF EXISTS `byte_bazaar`.`sold_to` ;
USE `byte_bazaar`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`user_1`@`%` SQL SECURITY DEFINER VIEW `byte_bazaar`.`sold_to` AS select `slr`.`seller_id` AS `seller_id`,`slr`.`name` AS `seller_name`,`p`.`product_id` AS `product_id`,`b`.`username` AS `buyer_username`,`sa`.`sale_id` AS `sale_id`,`sa`.`datetime` AS `sale_date` from (((((`byte_bazaar`.`seller` `slr` join `byte_bazaar`.`sells` `sls` on((`slr`.`seller_id` = `sls`.`seller_id`))) join `byte_bazaar`.`product` `p` on((`sls`.`product_id` = `p`.`product_id`))) join `byte_bazaar`.`sale` `sa` on((`sa`.`product_id` = `p`.`product_id`))) join `byte_bazaar`.`shipment` `sh` on((`sa`.`shipment_id` = `sh`.`shipment_id`))) join `byte_bazaar`.`buyer` `b` on((`sh`.`buyer_username` = `b`.`username`)));
USE `byte_bazaar`;

DELIMITER $$

USE `byte_bazaar`$$
DROP TRIGGER IF EXISTS `byte_bazaar`.`empty_cart` $$
USE `byte_bazaar`$$
CREATE
DEFINER=`user_1`@`%`
TRIGGER `byte_bazaar`.`empty_cart`
AFTER INSERT ON `byte_bazaar`.`shipment`
FOR EACH ROW
BEGIN 
	DELETE FROM cart
    WHERE cart.buyer_username = NEW.buyer_username;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
