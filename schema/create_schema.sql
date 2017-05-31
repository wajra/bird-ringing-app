-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema fogsl_ringing_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fogsl_ringing_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fogsl_ringing_database` DEFAULT CHARACTER SET utf8 ;
USE `fogsl_ringing_database` ;

-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`bird_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`bird_orders` (
  `order_index` INT NOT NULL AUTO_INCREMENT,
  `order_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_index`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`family`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`family` (
  `family_index` INT NOT NULL AUTO_INCREMENT,
  `order_index` INT NOT NULL,
  `family_name` VARCHAR(45) NOT NULL,
  `family_desc` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`family_index`),
  INDEX `order_fk_idx` (`order_index` ASC),
  CONSTRAINT `order_fk_1`
    FOREIGN KEY (`order_index`)
    REFERENCES `fogsl_ringing_database`.`bird_orders` (`order_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`species`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`species` (
  `species_index` INT NOT NULL AUTO_INCREMENT,
  `family_index` INT NOT NULL,
  `common_name` VARCHAR(60) NOT NULL,
  `scientific_name` VARCHAR(60) NOT NULL,
  `iucn_status` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`species_index`),
  INDEX `family_fk_idx` (`family_index` ASC),
  CONSTRAINT `family_fk_1`
    FOREIGN KEY (`family_index`)
    REFERENCES `fogsl_ringing_database`.`family` (`family_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`location` (
  `location_index` INT NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_index`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`institution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`institution` (
  `institution_index` INT NOT NULL AUTO_INCREMENT,
  `institution_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`institution_index`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`observer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`observer` (
  `observer_index` INT NOT NULL AUTO_INCREMENT,
  `observer_name` VARCHAR(45) NOT NULL,
  `institution_index` INT NOT NULL,
  PRIMARY KEY (`observer_index`),
  INDEX `instution_fk_1_idx` (`institution_index` ASC),
  CONSTRAINT `instution_fk_1`
    FOREIGN KEY (`institution_index`)
    REFERENCES `fogsl_ringing_database`.`institution` (`institution_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`ringing_session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`ringing_session` (
  `session_index` INT NOT NULL AUTO_INCREMENT,
  `session_name` VARCHAR(50) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`session_index`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`habitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`habitat` (
  `habitat_index` INT NOT NULL AUTO_INCREMENT,
  `habitat_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`habitat_index`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`capture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`capture` (
  `capture_index` INT NOT NULL AUTO_INCREMENT,
  `capture_date` DATE NOT NULL,
  `species_index` INT NOT NULL,
  `session_index` INT NOT NULL,
  `session_capture_number` INT NOT NULL,
  `location_index` INT NOT NULL,
  `habitat_index` INT NOT NULL,
  `observer_index` INT NOT NULL,
  `capture_time` TIME NOT NULL,
  `status_of_capture` ENUM('Alive', 'Dead') NULL DEFAULT 'Alive',
  `bird_escaped` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  `head_beak` DECIMAL(5,2) NULL,
  `ring_number` VARCHAR(15) NULL DEFAULT 'None',
  `beak_length` DECIMAL(5,2) NULL,
  `beak_depth` DECIMAL(5,2) NULL,
  `beak_width` DECIMAL(5,2) NULL,
  `head_moulting` ENUM('Yes', 'No', 'Ab') NULL,
  `body_moulting` ENUM('Yes', 'No', 'Ab') NULL,
  `plumage` ENUM('Breeding', 'Non-breeding', 'Juvenile', 'Non-breeding/Juvenile') NULL,
  `age` ENUM('Juvenile', 'Adult') NULL,
  `sex` ENUM('M', 'F', 'U') NULL,
  `fat_score` INT NULL,
  `brood_patch` ENUM('Y', 'N') NULL,
  `parasites` ENUM('Y', 'N') NULL,
  `beak_color` VARCHAR(45) NULL,
  `upper_mandible_color` VARCHAR(45) NULL,
  `lower_mandible_color` VARCHAR(45) NULL,
  `tarsus_color` VARCHAR(45) NULL,
  `feet_color` VARCHAR(45) NULL,
  `iris_color` VARCHAR(45) NULL,
  `eye_ring_color` VARCHAR(45) NULL,
  `tip_color` VARCHAR(45) NULL,
  `sample` ENUM('Blood', 'Feather', 'Blood/Feather', 'None') NULL DEFAULT 'None',
  PRIMARY KEY (`capture_index`),
  INDEX `species_fk_idx` (`species_index` ASC),
  INDEX `session_fk_idx` (`session_index` ASC),
  INDEX `location_fk_idx` (`location_index` ASC),
  INDEX `observer_fk_idx` (`observer_index` ASC),
  INDEX `habitat_fk_1_idx` (`habitat_index` ASC),
  UNIQUE INDEX `capture_date_UNIQUE` (`capture_date` ASC),
  UNIQUE INDEX `species_index_UNIQUE` (`species_index` ASC),
  UNIQUE INDEX `capture_time_UNIQUE` (`capture_time` ASC),
  CONSTRAINT `species_fk_1`
    FOREIGN KEY (`species_index`)
    REFERENCES `fogsl_ringing_database`.`species` (`species_index`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `session_fk_1`
    FOREIGN KEY (`session_index`)
    REFERENCES `fogsl_ringing_database`.`ringing_session` (`session_index`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `location_fk_1`
    FOREIGN KEY (`location_index`)
    REFERENCES `fogsl_ringing_database`.`location` (`location_index`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `observer_fk_1`
    FOREIGN KEY (`observer_index`)
    REFERENCES `fogsl_ringing_database`.`observer` (`observer_index`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `habitat_fk_1`
    FOREIGN KEY (`habitat_index`)
    REFERENCES `fogsl_ringing_database`.`habitat` (`habitat_index`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`species_synonyms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`species_synonyms` (
  `synonyms_index` INT NOT NULL AUTO_INCREMENT,
  `species_index` INT NOT NULL,
  `synonym` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`synonyms_index`),
  INDEX `species_fk_idx` (`species_index` ASC),
  CONSTRAINT `species_fk_2`
    FOREIGN KEY (`species_index`)
    REFERENCES `fogsl_ringing_database`.`species` (`species_index`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`wing_moulting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`wing_moulting` (
  `wing_moulting_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `feather_type` INT NOT NULL,
  `feather_number` INT NOT NULL,
  `moult_score` INT NOT NULL,
  PRIMARY KEY (`wing_moulting_index`),
  INDEX `capture_fk_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_2`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`weight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`weight` (
  `weight_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `bird_bag_weight` INT NOT NULL,
  `process_time` TIME NULL,
  `bag_weight` INT NOT NULL,
  PRIMARY KEY (`weight_index`),
  INDEX `capture_fk_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_8`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`wing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`wing` (
  `wing_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `wing_side` ENUM('L', 'R') NOT NULL,
  `wing_length` INT NOT NULL,
  PRIMARY KEY (`wing_index`),
  INDEX `capture_fk_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_6`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`tail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`tail` (
  `tail_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `tail_side` ENUM('L', 'R', 'M') NOT NULL,
  `tail_length` INT NOT NULL,
  PRIMARY KEY (`tail_index`),
  INDEX `capture_fk_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_5`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`tarsus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`tarsus` (
  `tarsus_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `tarsus_side` ENUM('L', 'R') NOT NULL,
  `tarsus_length` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`tarsus_index`),
  INDEX `capture_fk_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_3`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`remark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`remark` (
  `remark_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `remark_string` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`remark_index`),
  INDEX `capture_fk_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_7`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`colored_ring`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`colored_ring` (
  `ring_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `ring_side` ENUM('L', 'R') NOT NULL,
  `ring_order` INT NOT NULL,
  `ring_color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ring_index`),
  INDEX `capture_fk_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_4`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fogsl_ringing_database`.`tail_moulting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fogsl_ringing_database`.`tail_moulting` (
  `tail_moulting_index` INT NOT NULL AUTO_INCREMENT,
  `capture_index` INT NOT NULL,
  `tail_side` ENUM('L', 'R') NOT NULL,
  `feather_number` INT NULL,
  `moult_score` INT NOT NULL,
  PRIMARY KEY (`tail_moulting_index`),
  INDEX `capture_fk_14_idx` (`capture_index` ASC),
  CONSTRAINT `capture_fk_14`
    FOREIGN KEY (`capture_index`)
    REFERENCES `fogsl_ringing_database`.`capture` (`capture_index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
