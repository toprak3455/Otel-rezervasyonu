-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema otel_rezervasyon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema otel_rezervasyon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `otel_rezervasyon_db` DEFAULT CHARACTER SET utf8 ;
USE `otel_rezervasyon_db` ;

-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`OdaTipi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`OdaTipi` (
  `OdaTipiID` INT NOT NULL AUTO_INCREMENT,
  `TipAdi` VARCHAR(45) NOT NULL,
  `Kapasite` VARCHAR(45) NOT NULL,
  `Aciklama` VARCHAR(255) NULL,
  `TemelFiyat` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`OdaTipiID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`Oda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`Oda` (
  `OdaID` INT NOT NULL AUTO_INCREMENT,
  `OdaNumarasi` VARCHAR(10) NOT NULL,
  `Kat` VARCHAR(10) NULL,
  `Durum` ENUM('boş', 'dolu', 'temizlikte', 'bakımda') NOT NULL,
  `OdaTipi_OdaTipiID` INT NOT NULL,
  PRIMARY KEY (`OdaID`),
  UNIQUE INDEX `OdaNumarasi_UNIQUE` (`OdaNumarasi` ASC) VISIBLE,
  INDEX `fk_Oda_OdaTipi1_idx` (`OdaTipi_OdaTipiID` ASC) VISIBLE,
  CONSTRAINT `fk_Oda_OdaTipi1`
    FOREIGN KEY (`OdaTipi_OdaTipiID`)
    REFERENCES `otel_rezervasyon_db`.`OdaTipi` (`OdaTipiID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`SezonFiyati`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`SezonFiyati` (
  `SezonID` INT NOT NULL AUTO_INCREMENT,
  `BaslangicTarihi` DATE NOT NULL,
  `BitisTarihi` DATE NOT NULL,
  `GecelikFiyat` DECIMAL(10,2) NOT NULL,
  `OdaTipi_OdaTipiID` INT NOT NULL,
  PRIMARY KEY (`SezonID`),
  INDEX `fk_SezonFiyati_OdaTipi1_idx` (`OdaTipi_OdaTipiID` ASC) VISIBLE,
  CONSTRAINT `fk_SezonFiyati_OdaTipi1`
    FOREIGN KEY (`OdaTipi_OdaTipiID`)
    REFERENCES `otel_rezervasyon_db`.`OdaTipi` (`OdaTipiID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`Misafir`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`Misafir` (
  `MisafirID` INT NOT NULL AUTO_INCREMENT,
  `Ad` VARCHAR(50) NOT NULL,
  `Soyad` VARCHAR(50) NOT NULL,
  `KimlikNo` VARCHAR(20) NOT NULL,
  `Telefon` VARCHAR(15) NULL,
  `DogumTarihi` DATE NOT NULL,
  PRIMARY KEY (`MisafirID`),
  UNIQUE INDEX `KimlikNo_UNIQUE` (`KimlikNo` ASC) VISIBLE,
  UNIQUE INDEX `Telefon_UNIQUE` (`Telefon` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`Personel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`Personel` (
  `PersonelID` INT NOT NULL AUTO_INCREMENT,
  `Ad` VARCHAR(50) NOT NULL,
  `Soyad` VARCHAR(50) NOT NULL,
  `Gorev` ENUM('resepsiyon', 'kat görevlisi', 'yönetici') NOT NULL,
  `IseGirisTarihi` DATE NOT NULL,
  PRIMARY KEY (`PersonelID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`Kullanici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`Kullanici` (
  `KullaniciID` INT NOT NULL AUTO_INCREMENT,
  `Eposta` VARCHAR(100) NOT NULL,
  `Sifre` VARCHAR(255) NOT NULL,
  `Rol` ENUM('misafir', 'resepsiyon', 'yönetici') NOT NULL,
  `Misafir_MisafirID` INT NULL,
  `Personel_PersonelID` INT NULL,
  PRIMARY KEY (`KullaniciID`),
  UNIQUE INDEX `Eposta_UNIQUE` (`Eposta` ASC) VISIBLE,
  INDEX `fk_Kullanici_Misafir1_idx` (`Misafir_MisafirID` ASC) VISIBLE,
  INDEX `fk_Kullanici_Personel1_idx` (`Personel_PersonelID` ASC) VISIBLE,
  CONSTRAINT `fk_Kullanici_Misafir1`
    FOREIGN KEY (`Misafir_MisafirID`)
    REFERENCES `otel_rezervasyon_db`.`Misafir` (`MisafirID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kullanici_Personel1`
    FOREIGN KEY (`Personel_PersonelID`)
    REFERENCES `otel_rezervasyon_db`.`Personel` (`PersonelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`Rezervasyon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`Rezervasyon` (
  `RezervasyonID` INT NOT NULL AUTO_INCREMENT,
  `GirisTarihi` DATE NOT NULL,
  `CikisTarihi` DATE NOT NULL,
  `KisiSayisi` INT NOT NULL,
  `Durum` ENUM('beklemede', 'onaylı', 'iptal', 'tamamlandı') NOT NULL,
  `OlusturmaTarihi` DATETIME NOT NULL,
  `Misafir_MisafirID` INT NOT NULL,
  `Oda_OdaID` INT NOT NULL,
  PRIMARY KEY (`RezervasyonID`),
  INDEX `fk_Rezervasyon_Misafir1_idx` (`Misafir_MisafirID` ASC) VISIBLE,
  INDEX `fk_Rezervasyon_Oda1_idx` (`Oda_OdaID` ASC) VISIBLE,
  CONSTRAINT `fk_Rezervasyon_Misafir1`
    FOREIGN KEY (`Misafir_MisafirID`)
    REFERENCES `otel_rezervasyon_db`.`Misafir` (`MisafirID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rezervasyon_Oda1`
    FOREIGN KEY (`Oda_OdaID`)
    REFERENCES `otel_rezervasyon_db`.`Oda` (`OdaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`Konaklama`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`Konaklama` (
  `KonaklamaID` INT NOT NULL AUTO_INCREMENT,
  `GercekGirisZamani` DATETIME NULL,
  `GercekCikisZamani` DATETIME NULL,
  `Rezervasyon_RezervasyonID` INT NOT NULL,
  `Personel_PersonelID` INT NOT NULL,
  PRIMARY KEY (`KonaklamaID`),
  INDEX `fk_Konaklama_Rezervasyon1_idx` (`Rezervasyon_RezervasyonID` ASC) VISIBLE,
  INDEX `fk_Konaklama_Personel1_idx` (`Personel_PersonelID` ASC) VISIBLE,
  CONSTRAINT `fk_Konaklama_Rezervasyon1`
    FOREIGN KEY (`Rezervasyon_RezervasyonID`)
    REFERENCES `otel_rezervasyon_db`.`Rezervasyon` (`RezervasyonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Konaklama_Personel1`
    FOREIGN KEY (`Personel_PersonelID`)
    REFERENCES `otel_rezervasyon_db`.`Personel` (`PersonelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`EkHizmet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`EkHizmet` (
  `HizmetID` INT NOT NULL AUTO_INCREMENT,
  `HizmetAdi` VARCHAR(100) NOT NULL,
  `BirimFiyat` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`HizmetID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`KonaklamaHizmeti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`KonaklamaHizmeti` (
  `KayitID` INT NOT NULL AUTO_INCREMENT,
  `Adet` INT NOT NULL,
  `Tarih` DATETIME NOT NULL,
  `Konaklama_KonaklamaID` INT NOT NULL,
  `EkHizmet_HizmetID` INT NOT NULL,
  PRIMARY KEY (`KayitID`),
  INDEX `fk_KonaklamaHizmeti_Konaklama1_idx` (`Konaklama_KonaklamaID` ASC) VISIBLE,
  INDEX `fk_KonaklamaHizmeti_EkHizmet1_idx` (`EkHizmet_HizmetID` ASC) VISIBLE,
  CONSTRAINT `fk_KonaklamaHizmeti_Konaklama1`
    FOREIGN KEY (`Konaklama_KonaklamaID`)
    REFERENCES `otel_rezervasyon_db`.`Konaklama` (`KonaklamaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_KonaklamaHizmeti_EkHizmet1`
    FOREIGN KEY (`EkHizmet_HizmetID`)
    REFERENCES `otel_rezervasyon_db`.`EkHizmet` (`HizmetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`Odeme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`Odeme` (
  `OdemeID` INT NOT NULL AUTO_INCREMENT,
  `Tutar` DECIMAL(10,2) NOT NULL,
  `OdemeTuru` ENUM('nakit', 'kart') NOT NULL,
  `Tarih` DATETIME NOT NULL,
  `Konaklama_KonaklamaID` INT NOT NULL,
  PRIMARY KEY (`OdemeID`),
  INDEX `fk_Odeme_Konaklama1_idx` (`Konaklama_KonaklamaID` ASC) VISIBLE,
  CONSTRAINT `fk_Odeme_Konaklama1`
    FOREIGN KEY (`Konaklama_KonaklamaID`)
    REFERENCES `otel_rezervasyon_db`.`Konaklama` (`KonaklamaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`TemizlikKaydi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`TemizlikKaydi` (
  `KayitID` INT NOT NULL AUTO_INCREMENT,
  `Tarih` DATETIME NOT NULL,
  `Durum` ENUM('tamamlandı', 'yapılmadı') NOT NULL,
  `Oda_OdaID` INT NOT NULL,
  `Personel_PersonelID` INT NOT NULL,
  PRIMARY KEY (`KayitID`),
  INDEX `fk_TemizlikKaydi_Oda1_idx` (`Oda_OdaID` ASC) VISIBLE,
  INDEX `fk_TemizlikKaydi_Personel1_idx` (`Personel_PersonelID` ASC) VISIBLE,
  CONSTRAINT `fk_TemizlikKaydi_Oda1`
    FOREIGN KEY (`Oda_OdaID`)
    REFERENCES `otel_rezervasyon_db`.`Oda` (`OdaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TemizlikKaydi_Personel1`
    FOREIGN KEY (`Personel_PersonelID`)
    REFERENCES `otel_rezervasyon_db`.`Personel` (`PersonelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `otel_rezervasyon_db`.`IslemLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `otel_rezervasyon_db`.`IslemLog` (
  `LogID` INT NOT NULL AUTO_INCREMENT,
  `TabloAdi` VARCHAR(50) NOT NULL,
  `IslemZamani` DATETIME NOT NULL,
  `Detay` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`LogID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
