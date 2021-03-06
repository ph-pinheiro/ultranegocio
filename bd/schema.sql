SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `ultranegocio` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ultranegocio` ;

-- -----------------------------------------------------
-- Table `ultranegocio`.`usuarios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ultranegocio`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(245) NULL ,
  `email` VARCHAR(245) NULL ,
  `senha` VARCHAR(245) NULL ,
  `created` DATETIME NULL ,
  `modified` DATETIME NULL ,
  `deleted` TINYINT(1) NULL DEFAULT 0 ,
  `email_confirmado` TINYINT(1) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ultranegocio`.`anuncios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ultranegocio`.`anuncios` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `titulo` VARCHAR(245) NULL ,
  `descricao` LONGBLOB NULL ,
  `preco` FLOAT NULL ,
  `created` DATETIME NULL ,
  `modified` DATETIME NULL ,
  `deleted` TINYINT(1) NULL DEFAULT 0 ,
  `peso` FLOAT NULL ,
  `cep_origem` VARCHAR(45) NULL ,
  `usuario_id` INT NOT NULL ,
  `keywords` TEXT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_anuncios_usuarios1_idx` (`usuario_id` ASC) ,
  CONSTRAINT `fk_anuncios_usuarios1`
    FOREIGN KEY (`usuario_id` )
    REFERENCES `ultranegocio`.`usuarios` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ultranegocio`.`imagens`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ultranegocio`.`imagens` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `created` DATETIME NULL ,
  `titulo` VARCHAR(250) NULL ,
  `descricao` TEXT NULL ,
  `anuncio_id` INT NOT NULL ,
  `alt` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_imagens_anuncios_idx` (`anuncio_id` ASC) ,
  CONSTRAINT `fk_imagens_anuncios`
    FOREIGN KEY (`anuncio_id` )
    REFERENCES `ultranegocio`.`anuncios` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ultranegocio`.`tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ultranegocio`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tag` VARCHAR(245) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ultranegocio`.`anuncios_tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ultranegocio`.`anuncios_tags` (
  `tag_id` INT NOT NULL ,
  `anuncio_id` INT NOT NULL ,
  PRIMARY KEY (`tag_id`, `anuncio_id`) ,
  INDEX `fk_tags_has_anuncios_anuncios1_idx` (`anuncio_id` ASC) ,
  INDEX `fk_tags_has_anuncios_tags1_idx` (`tag_id` ASC) ,
  CONSTRAINT `fk_tags_has_anuncios_tags1`
    FOREIGN KEY (`tag_id` )
    REFERENCES `ultranegocio`.`tags` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_has_anuncios_anuncios1`
    FOREIGN KEY (`anuncio_id` )
    REFERENCES `ultranegocio`.`anuncios` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ultranegocio`.`tipo_destaques`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ultranegocio`.`tipo_destaques` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tipo` VARCHAR(245) NULL ,
  `descricao` TEXT NULL ,
  `valor` FLOAT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ultranegocio`.`destaques`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ultranegocio`.`destaques` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `created` DATETIME NULL ,
  `modified` DATETIME NULL ,
  `valor` FLOAT NULL ,
  `pago` TINYINT(1) NULL DEFAULT 0 ,
  `transacao_id` VARCHAR(245) NULL ,
  `situacao` VARCHAR(245) NULL ,
  `tipo_destaque_id` INT NOT NULL ,
  `anuncio_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_destaques_tipo_destaques1_idx` (`tipo_destaque_id` ASC) ,
  INDEX `fk_destaques_anuncios1_idx` (`anuncio_id` ASC) ,
  CONSTRAINT `fk_destaques_tipo_destaques1`
    FOREIGN KEY (`tipo_destaque_id` )
    REFERENCES `ultranegocio`.`tipo_destaques` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destaques_anuncios1`
    FOREIGN KEY (`anuncio_id` )
    REFERENCES `ultranegocio`.`anuncios` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `ultranegocio` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
