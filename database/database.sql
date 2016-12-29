-- MySQL Script generated by MySQL Workbench
-- Thu Dec 29 13:08:47 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ogl_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_role` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_role` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `cdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(128) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `surname` VARCHAR(128) NULL,
  `role` INT NOT NULL DEFAULT 1,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `access_token` VARCHAR(255) NOT NULL,
  `cdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_ogl_user_1_idx` (`role` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`id` ASC),
  PRIMARY KEY (),
  INDEX `fk_i_field_id` (),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC),
  UNIQUE INDEX `access_token_UNIQUE` (`access_token` ASC),
  CONSTRAINT `fk_ogl_user_1`
    FOREIGN KEY (`role`)
    REFERENCES `mydb`.`ogl_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_shop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_shop` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_shop` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `owner` INT NOT NULL,
  `category` INT NOT NULL,
  `deadline` DATETIME NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `logo` VARCHAR(45) NOT NULL,
  `cdate` VARCHAR(45) NULL,
  `edate` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ogl_shop_1_idx` (`owner` ASC),
  CONSTRAINT `fk_ogl_shop_1`
    FOREIGN KEY (`owner`)
    REFERENCES `mydb`.`ogl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_category_filter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_category_filter` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_category_filter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `filter` JSON NOT NULL,
  `edate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `filter_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `cdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC),
  INDEX `fk_ogl_category_filter_idx` (`filter_id` ASC),
  CONSTRAINT `fk_ogl_category_filter`
    FOREIGN KEY (`filter_id`)
    REFERENCES `mydb`.`ogl_category_filter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_country` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_country` (
  `country_id` INT NOT NULL,
  `c_name` VARCHAR(128) NOT NULL,
  `en_c_name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE INDEX `country_id_UNIQUE` (`country_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_region` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_region` (
  `region_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `r_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE INDEX `id_region_UNIQUE` (`region_id` ASC),
  INDEX `fk_ogl_region_1_idx` (`country_id` ASC),
  CONSTRAINT `fk_ogl_region_1`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`ogl_country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_city` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_city` (
  `city_id` INT NOT NULL,
  `region_id` INT NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `town` VARCHAR(128) NULL,
  `settlement` VARCHAR(128) NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE INDEX `city_id_UNIQUE` (`city_id` ASC),
  INDEX `fk_ogl_city_1_idx` (`region_id` ASC),
  CONSTRAINT `fk_ogl_city_1`
    FOREIGN KEY (`region_id`)
    REFERENCES `mydb`.`ogl_region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_video` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `url` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `video_id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_add`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_add` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_add` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cat_id` INT NOT NULL,
  `filter` JSON NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `text` TEXT NOT NULL,
  `price` INT(11) NOT NULL,
  `city_id` INT NOT NULL,
  `map_coordinates` JSON NOT NULL,
  `type` INT NOT NULL DEFAULT 1,
  `expdate` DATETIME NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `creator_id` INT NOT NULL,
  `video_id` INT NULL,
  `cdate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_ogl_add_1_idx` (`creator_id` ASC),
  INDEX `fk_ogl_add_3_idx` (`city_id` ASC),
  INDEX `fk_ogl_add_2_idx` (`cat_id` ASC),
  INDEX `fk_to_video_idx` (`video_id` ASC),
  CONSTRAINT `fk_ogl_add_1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `mydb`.`ogl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ogl_add_2`
    FOREIGN KEY (`cat_id`)
    REFERENCES `mydb`.`ogl_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ogl_add_3`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`ogl_city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_to_video`
    FOREIGN KEY (`video_id`)
    REFERENCES `mydb`.`ogl_video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_photo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_photo` (
  `photo_id` INT NOT NULL,
  `add_id` INT NOT NULL,
  `photo_name` VARCHAR(128) NULL,
  `photo_url` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`photo_id`),
  INDEX `fk_ogl_photo_1_idx` (`add_id` ASC),
  UNIQUE INDEX `photo_id_UNIQUE` (`photo_id` ASC),
  UNIQUE INDEX `add_id_UNIQUE` (`add_id` ASC),
  CONSTRAINT `fk_ogl_photo_1`
    FOREIGN KEY (`add_id`)
    REFERENCES `mydb`.`ogl_add` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_comments` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_comments` (
  `comm_id` INT(64) NOT NULL,
  `cat_id` INT NULL,
  `add_id` INT NULL,
  `author` VARCHAR(64) NULL,
  `text` TEXT NULL,
  `checked` ENUM('yes', 'no') NULL DEFAULT 'no',
  `cdate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `edate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comm_id`),
  UNIQUE INDEX `comm_id_UNIQUE` (`comm_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_news` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_news` (
  `news_id` INT NOT NULL AUTO_INCREMENT,
  `add_id` INT NULL,
  `author` VARCHAR(64) NULL,
  `text` TEXT NULL,
  `checked` ENUM('yes', 'no') NULL DEFAULT 'no',
  `cdate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `edate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`news_id`),
  UNIQUE INDEX `news_id_UNIQUE` (`news_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_claim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_claim` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_claim` (
  `claim_id` INT NOT NULL AUTO_INCREMENT,
  `add_id` INT NULL,
  `claim_title` VARCHAR(255) NOT NULL,
  `claim_text` TEXT NOT NULL,
  PRIMARY KEY (`claim_id`),
  UNIQUE INDEX `claim_id_UNIQUE` (`claim_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_admin` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_admin` (
  `login` VARCHAR(32) NOT NULL,
  `passwod` VARCHAR(64) NULL,
  PRIMARY KEY (`login`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ogl_subscribe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ogl_subscribe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ogl_subscribe` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(128) NULL,
  `user_name` VARCHAR(128) NULL,
  `add_id` INT NULL,
  `cat_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
