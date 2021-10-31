-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema vuelos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema vuelos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vuelos` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `vuelos` ;

-- -----------------------------------------------------
-- Table `vuelos`.`aerolinea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`aerolinea` (
  `idAerolinea` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(70) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idAerolinea`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`aeropuerto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`aeropuerto` (
  `idAeropuerto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `pais` VARCHAR(50) NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`idAeropuerto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`avion` (
  `idAvion` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(100) NOT NULL,
  `capacidad` INT NOT NULL,
  `idAerolinea` INT NOT NULL,
  PRIMARY KEY (`idAvion`),
  INDEX `fk_AvionAerolinea` (`idAerolinea` ASC) VISIBLE,
  CONSTRAINT `fk_AvionAerolinea`
    FOREIGN KEY (`idAerolinea`)
    REFERENCES `vuelos`.`aerolinea` (`idAerolinea`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`aeropuerto_avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`aeropuerto_avion` (
  `idAeropuertoAvion` INT NOT NULL AUTO_INCREMENT,
  `idAeropuerto` INT NOT NULL,
  `idAvion` INT NOT NULL,
  PRIMARY KEY (`idAeropuertoAvion`),
  INDEX `fk_AeAvAeropuerto_idx` (`idAeropuerto` ASC) VISIBLE,
  INDEX `fk_AeAvAvion_idx` (`idAvion` ASC) VISIBLE,
  CONSTRAINT `fk_AeAvAeropuerto`
    FOREIGN KEY (`idAeropuerto`)
    REFERENCES `vuelos`.`aeropuerto` (`idAeropuerto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_AeAvAvion`
    FOREIGN KEY (`idAvion`)
    REFERENCES `vuelos`.`avion` (`idAvion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`pasajero` (
  `idPasajero` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `identificacion` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `direccion` VARCHAR(70) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPasajero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`vuelo` (
  `idVuelo` INT NOT NULL AUTO_INCREMENT,
  `numeroVuelo` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `idAvion` INT NOT NULL,
  PRIMARY KEY (`idVuelo`),
  INDEX `fk_VueloAvion_idx` (`idAvion` ASC) VISIBLE,
  CONSTRAINT `fk_VueloAvion`
    FOREIGN KEY (`idAvion`)
    REFERENCES `vuelos`.`avion` (`idAvion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`ruta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`ruta` (
  `idRuta` INT NOT NULL AUTO_INCREMENT,
  `origen` VARCHAR(45) NOT NULL,
  `destino` VARCHAR(45) NOT NULL,
  `fechaSalida` DATE NOT NULL,
  `fechaLlegada` DATE NOT NULL,
  `horaSalida` VARCHAR(45) NOT NULL,
  `horaLlegada` VARCHAR(45) NOT NULL,
  `idAeropuerto` INT NOT NULL,
  `idVuelo` INT NOT NULL,
  PRIMARY KEY (`idRuta`),
  INDEX `fk_RutaAeropuerto_idx` (`idAeropuerto` ASC) VISIBLE,
  INDEX `fk_RutaVuelo_idx` (`idVuelo` ASC) VISIBLE,
  CONSTRAINT `fk_RutaAeropuerto`
    FOREIGN KEY (`idAeropuerto`)
    REFERENCES `vuelos`.`aeropuerto` (`idAeropuerto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_RutaVuelo`
    FOREIGN KEY (`idVuelo`)
    REFERENCES `vuelos`.`vuelo` (`idVuelo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`ticket` (
  `idTicket` INT NOT NULL AUTO_INCREMENT,
  `costo` DOUBLE NOT NULL,
  `asiento` VARCHAR(45) NOT NULL,
  `clase` VARCHAR(45) NOT NULL,
  `fechaCompra` DATE NOT NULL,
  `horaCompra` VARCHAR(45) NOT NULL,
  `idVuelo` INT NOT NULL,
  `idPasajero` INT NOT NULL,
  PRIMARY KEY (`idTicket`),
  INDEX `fk_TicketVuelo_idx` (`idVuelo` ASC) VISIBLE,
  INDEX `fk_TicketPasajero_idx` (`idPasajero` ASC) VISIBLE,
  CONSTRAINT `fk_TicketPasajero`
    FOREIGN KEY (`idPasajero`)
    REFERENCES `vuelos`.`pasajero` (`idPasajero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TicketVuelo`
    FOREIGN KEY (`idVuelo`)
    REFERENCES `vuelos`.`vuelo` (`idVuelo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `vuelos`.`tripulacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vuelos`.`tripulacion` (
  `idTripulacion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `identificacion` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `idVuelo` INT NOT NULL,
  PRIMARY KEY (`idTripulacion`),
  INDEX `fk_TripulacionVuelo_idx` (`idVuelo` ASC) VISIBLE,
  CONSTRAINT `fk_TripulacionVuelo`
    FOREIGN KEY (`idVuelo`)
    REFERENCES `vuelos`.`vuelo` (`idVuelo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
