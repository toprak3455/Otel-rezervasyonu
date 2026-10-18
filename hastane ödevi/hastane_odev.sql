-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Poliklinik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Poliklinik` (
  `poliklinik_id` INT NOT NULL,
  `poliklinik_adi` VARCHAR(45) NULL,
  PRIMARY KEY (`poliklinik_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doktor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doktor` (
  `doktor_id` INT NOT NULL,
  `ad` VARCHAR(45) NULL,
  `soyad` VARCHAR(45) NULL,
  `Poliklinik_poliklinik_id` INT NOT NULL,
  PRIMARY KEY (`doktor_id`),
  INDEX `fk_Doktor_Poliklinik_idx` (`Poliklinik_poliklinik_id` ASC) VISIBLE,
  CONSTRAINT `fk_Doktor_Poliklinik`
    FOREIGN KEY (`Poliklinik_poliklinik_id`)
    REFERENCES `mydb`.`Poliklinik` (`poliklinik_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hasta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hasta` (
  `hasta_id` INT NOT NULL,
  `ad` VARCHAR(45) NULL,
  `soyad` VARCHAR(45) NULL,
  PRIMARY KEY (`hasta_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Muayene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Muayene` (
  `Hasta_hasta_id` INT NOT NULL,
  `Poliklinik_poliklinik_id` INT NOT NULL,
  PRIMARY KEY (`Hasta_hasta_id`, `Poliklinik_poliklinik_id`),
  INDEX `fk_Hasta_has_Poliklinik_Poliklinik1_idx` (`Poliklinik_poliklinik_id` ASC) VISIBLE,
  INDEX `fk_Hasta_has_Poliklinik_Hasta1_idx` (`Hasta_hasta_id` ASC) VISIBLE,
  CONSTRAINT `fk_Hasta_has_Poliklinik_Hasta1`
    FOREIGN KEY (`Hasta_hasta_id`)
    REFERENCES `mydb`.`Hasta` (`hasta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hasta_has_Poliklinik_Poliklinik1`
    FOREIGN KEY (`Poliklinik_poliklinik_id`)
    REFERENCES `mydb`.`Poliklinik` (`poliklinik_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Laboratuvar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Laboratuvar` (
  `lab_id` INT NOT NULL,
  `lab_adi` VARCHAR(45) NULL,
  PRIMARY KEY (`lab_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tahlil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tahlil` (
  `tahlil_id` INT NOT NULL,
  `tahlil_adi` VARCHAR(45) NULL,
  `Laboratuvar_lab_id` INT NOT NULL,
  PRIMARY KEY (`tahlil_id`, `Laboratuvar_lab_id`),
  INDEX `fk_tahlil_Laboratuvar1_idx` (`Laboratuvar_lab_id` ASC) VISIBLE,
  CONSTRAINT `fk_tahlil_Laboratuvar1`
    FOREIGN KEY (`Laboratuvar_lab_id`)
    REFERENCES `mydb`.`Laboratuvar` (`lab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hasta_tahlil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hasta_tahlil` (
  `Hasta_hasta_id` INT NOT NULL,
  `tahlil_tahlil_id` INT NOT NULL,
  `tahlil_Laboratuvar_lab_id` INT NOT NULL,
  `Doktor_doktor_id` INT NOT NULL,
  PRIMARY KEY (`Hasta_hasta_id`, `tahlil_tahlil_id`, `tahlil_Laboratuvar_lab_id`),
  INDEX `fk_Hasta_has_tahlil_tahlil1_idx` (`tahlil_tahlil_id` ASC, `tahlil_Laboratuvar_lab_id` ASC) VISIBLE,
  INDEX `fk_Hasta_has_tahlil_Hasta1_idx` (`Hasta_hasta_id` ASC) VISIBLE,
  INDEX `fk_Hasta_tahlil_Doktor1_idx` (`Doktor_doktor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Hasta_has_tahlil_Hasta1`
    FOREIGN KEY (`Hasta_hasta_id`)
    REFERENCES `mydb`.`Hasta` (`hasta_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hasta_has_tahlil_tahlil1`
    FOREIGN KEY (`tahlil_tahlil_id` , `tahlil_Laboratuvar_lab_id`)
    REFERENCES `mydb`.`tahlil` (`tahlil_id` , `Laboratuvar_lab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hasta_tahlil_Doktor1`
    FOREIGN KEY (`Doktor_doktor_id`)
    REFERENCES `mydb`.`Doktor` (`doktor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servis` (
  `servis_id` INT NOT NULL,
  `servis_adi` VARCHAR(45) NULL,
  `Poliklinik_poliklinik_id` INT NOT NULL,
  PRIMARY KEY (`servis_id`),
  INDEX `fk_Servis_Poliklinik1_idx` (`Poliklinik_poliklinik_id` ASC) VISIBLE,
  CONSTRAINT `fk_Servis_Poliklinik1`
    FOREIGN KEY (`Poliklinik_poliklinik_id`)
    REFERENCES `mydb`.`Poliklinik` (`poliklinik_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hemsire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hemsire` (
  `hemsire_id` INT NOT NULL,
  `ad` VARCHAR(45) NULL,
  `soyad` VARCHAR(45) NULL,
  `Servis_servis_id` INT NOT NULL,
  PRIMARY KEY (`hemsire_id`),
  INDEX `fk_hemsire_Servis1_idx` (`Servis_servis_id` ASC) VISIBLE,
  CONSTRAINT `fk_hemsire_Servis1`
    FOREIGN KEY (`Servis_servis_id`)
    REFERENCES `mydb`.`Servis` (`servis_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
