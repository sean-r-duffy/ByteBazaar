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
CREATE SCHEMA IF NOT EXISTS `byte_bazaar` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`platform` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`platform` (
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`image` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`image` (
  `url` VARCHAR(100) NOT NULL,
  `product_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`url`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `image_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `byte_bazaar`.`product` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`payment` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`payment` (
  `card_number` INT NOT NULL AUTO_INCREMENT,
  `buyer_username` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`card_number`),
  INDEX `buyer_username` (`buyer_username` ASC) VISIBLE,
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`buyer_username`)
    REFERENCES `byte_bazaar`.`buyer` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `byte_bazaar`.`shipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `byte_bazaar`.`shipment` ;

CREATE TABLE IF NOT EXISTS `byte_bazaar`.`shipment` (
  `shipment_id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NULL DEFAULT NULL,
  `buyer_username` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`shipment_id`),
  INDEX `address_id` (`address_id` ASC) VISIBLE,
  INDEX `buyer_username` (`buyer_username` ASC) VISIBLE,
  CONSTRAINT `shipment_ibfk_1`
    FOREIGN KEY (`address_id`)
    REFERENCES `byte_bazaar`.`address` (`address_id`),
  CONSTRAINT `shipment_ibfk_2`
    FOREIGN KEY (`buyer_username`)
    REFERENCES `byte_bazaar`.`buyer` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
