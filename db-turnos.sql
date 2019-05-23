-- MySQL Script generated by MySQL Workbench
-- mar 21 may 2019 17:40:35 -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema turnos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema turnos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `turnos` ;
USE `turnos` ;

-- -----------------------------------------------------
-- Table `turnos`.`ObraSocial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turnos`.`ObraSocial` (
  `idObraSocial` INT(6) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idObraSocial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `turnos`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turnos`.`Paciente` (
  `idPaciente` INT(6) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `dni` INT(8) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `telefono` INT(10) NOT NULL,
  `ObraSocial_idObraSocial` INT(6) NOT NULL,
  PRIMARY KEY (`idPaciente`),
  INDEX `fk_Paciente_ObraSocial1_idx` (`ObraSocial_idObraSocial` ASC),
  CONSTRAINT `fk_Paciente_ObraSocial1`
    FOREIGN KEY (`ObraSocial_idObraSocial`)
    REFERENCES `turnos`.`ObraSocial` (`idObraSocial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `turnos`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turnos`.`Medico` (
  `idMedico` INT(6) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `dni` INT(8) NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  `estado_civil` VARCHAR(10) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `matricula` INT(20) NOT NULL,
  `especialidad` VARCHAR(45) NOT NULL,
  `ObraSocial_idObraSocial` INT(6) NOT NULL,
  PRIMARY KEY (`idMedico`),
  INDEX `fk_Medico_ObraSocial1_idx` (`ObraSocial_idObraSocial` ASC),
  CONSTRAINT `fk_Medico_ObraSocial1`
    FOREIGN KEY (`ObraSocial_idObraSocial`)
    REFERENCES `turnos`.`ObraSocial` (`idObraSocial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `turnos`.`Turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turnos`.`Turno` (
  `idTurno` INT(6) NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `motivo_consulta` VARCHAR(50) NOT NULL,
  `obra_social` TINYINT NOT NULL DEFAULT 0,
  `Paciente_idPaciente` INT(6) NOT NULL,
  `Medico_idMedico` INT(6) NOT NULL,
  PRIMARY KEY (`idTurno`),
  INDEX `fk_Turno_Paciente_idx` (`Paciente_idPaciente` ASC),
  INDEX `fk_Turno_Medico1_idx` (`Medico_idMedico` ASC),
  CONSTRAINT `fk_Turno_Paciente`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `turnos`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turno_Medico1`
    FOREIGN KEY (`Medico_idMedico`)
    REFERENCES `turnos`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
