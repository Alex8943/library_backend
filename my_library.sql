-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema stohtpsd_my_library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema stohtpsd_my_library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stohtpsd_my_library` DEFAULT CHARACTER SET utf8mb3 ;
USE `stohtpsd_my_library` ;

-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `total_books` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`books` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `picture` VARCHAR(45) NULL DEFAULT NULL,
  `summary` VARCHAR(800) NOT NULL,
  `pages` INT NOT NULL DEFAULT '0',
  `amount` INT NOT NULL DEFAULT '1',
  `available_amount` INT NOT NULL DEFAULT '1',
  `author_id` INT NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE INDEX `book_id_UNIQUE` (`book_id` ASC) VISIBLE,
  INDEX `author_id_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `author_id_books`
    FOREIGN KEY (`author_id`)
    REFERENCES `stohtpsd_my_library`.`authors` (`author_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` TINYINT NOT NULL DEFAULT '0',
  `deleted_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`book_interactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`book_interactions` (
  `book_interaction_id` INT NOT NULL AUTO_INCREMENT,
  `book_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `interaction_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`book_interaction_id`),
  INDEX `book_id_idx` (`book_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `book_id_bi`
    FOREIGN KEY (`book_id`)
    REFERENCES `stohtpsd_my_library`.`books` (`book_id`),
  CONSTRAINT `user_id_bi`
    FOREIGN KEY (`user_id`)
    REFERENCES `stohtpsd_my_library`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`favorited_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`favorited_authors` (
  `favorited_id` INT NOT NULL AUTO_INCREMENT,
  `author_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`favorited_id`),
  INDEX `author_id_idx` (`author_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `author_id_fa`
    FOREIGN KEY (`author_id`)
    REFERENCES `stohtpsd_my_library`.`authors` (`author_id`),
  CONSTRAINT `user_id_fa`
    FOREIGN KEY (`user_id`)
    REFERENCES `stohtpsd_my_library`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`reviews` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `stars` INT NOT NULL DEFAULT '3',
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `book_id_reviews`
    FOREIGN KEY (`book_id`)
    REFERENCES `stohtpsd_my_library`.`books` (`book_id`),
  CONSTRAINT `user_id_reviews`
    FOREIGN KEY (`user_id`)
    REFERENCES `stohtpsd_my_library`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`tags` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(30) NOT NULL,
  `tag_description` VARCHAR(45) NULL DEFAULT 'Description missing',
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`tag_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`tag_books` (
  `tag_book_id` INT NOT NULL AUTO_INCREMENT,
  `book_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`tag_book_id`),
  INDEX `book_id_idx` (`book_id` ASC) VISIBLE,
  INDEX `tag_id_idx` (`tag_id` ASC) VISIBLE,
  CONSTRAINT `book_id_tb`
    FOREIGN KEY (`book_id`)
    REFERENCES `stohtpsd_my_library`.`books` (`book_id`),
  CONSTRAINT `tag_id_tb`
    FOREIGN KEY (`tag_id`)
    REFERENCES `stohtpsd_my_library`.`tags` (`tag_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`user_names`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`user_names` (
  `name_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `stohtpsd_my_library`.`users_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`users_data` (
  `users_data_id` INT NOT NULL AUTO_INCREMENT,
  `name_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `pass` VARCHAR(90) NOT NULL,
  `snap_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`users_data_id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `name_id_idx` (`name_id` ASC) VISIBLE,
  CONSTRAINT `name_id_ud`
    FOREIGN KEY (`name_id`)
    REFERENCES `stohtpsd_my_library`.`user_names` (`name_id`),
  CONSTRAINT `user_id_ud`
    FOREIGN KEY (`user_id`)
    REFERENCES `stohtpsd_my_library`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = utf8mb3;

USE `stohtpsd_my_library` ;

-- -----------------------------------------------------
-- Placeholder table for view `stohtpsd_my_library`.`author_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`author_books` (`title` INT, `username` INT);

-- -----------------------------------------------------
-- Placeholder table for view `stohtpsd_my_library`.`most_popular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stohtpsd_my_library`.`most_popular` (`title` INT, `stars` INT);

-- -----------------------------------------------------
-- procedure create_user
-- -----------------------------------------------------

DELIMITER $$
USE `stohtpsd_my_library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_user`(
  IN first_name VARCHAR(45),
  IN last_name VARCHAR(45),
  IN email VARCHAR(45),
  IN pass VARCHAR(90)
)
BEGIN
	DECLARE last_user_id INT;
	DECLARE last_name_id INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;
  
  -- Insert into user_names table
  INSERT INTO user_names (first_name, last_name)
  VALUES (first_name, last_name);

  -- Get the auto-generated name_id
  SET last_name_id = LAST_INSERT_ID();

  -- Insert into users table
  INSERT INTO users (is_deleted)
  VALUES (0);

  -- Get the auto-generated user_id
  SET last_user_id = LAST_INSERT_ID();

  -- Insert into users_data table
  INSERT INTO users_data (name_id, user_id, email, pass)
  VALUES (last_name_id, last_user_id, email, pass); 
  COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_book_with_author
-- -----------------------------------------------------

DELIMITER $$
USE `stohtpsd_my_library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_book_with_author`(IN authorId INT)
BEGIN
  SELECT
    b.book_id,
    b.title,
    b.picture,
    b.summary,
    b.pages,
    b.amount,
    b.available_amount,
    a.username
  FROM books b
  JOIN authors a ON b.author_id = a.author_id
  WHERE a.author_id = authorId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_user_information
-- -----------------------------------------------------

DELIMITER $$
USE `stohtpsd_my_library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_information`(IN userId INT)
BEGIN
  SELECT
    u.user_id,
    u.created_at,
    u.is_deleted,
    u.deleted_at,
    un.first_name,
    un.last_name,
    ud.email,
    ud.pass,
    ud.snap_timestamp
  FROM users u
  JOIN users_data ud ON u.user_id = ud.user_id
  JOIN user_names un ON ud.name_id = un.name_id
  WHERE u.user_id = userId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_user
-- -----------------------------------------------------

DELIMITER $$
USE `stohtpsd_my_library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(
    IN p_name_id INT,
    IN p_first_name VARCHAR(45),
    IN p_last_name VARCHAR(45),
    IN p_user_id INT,
    IN p_email VARCHAR(45),
    IN p_pass VARCHAR(90)
)
BEGIN
    START TRANSACTION;

    -- Update the name in user_names table
    UPDATE user_names
    SET first_name = p_first_name, last_name = p_last_name
    WHERE name_id = p_name_id;

    -- Insert a new record into users_data table
    INSERT INTO users_data (name_id, user_id, email, pass)
    VALUES (p_name_id, p_user_id, p_email, p_pass);

    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `stohtpsd_my_library`.`author_books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stohtpsd_my_library`.`author_books`;
USE `stohtpsd_my_library`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stohtpsd_my_library`.`author_books` AS select `b`.`title` AS `title`,`a`.`username` AS `username` from (`stohtpsd_my_library`.`authors` `a` join `stohtpsd_my_library`.`books` `b`) where (`a`.`author_id` = `b`.`author_id`);

-- -----------------------------------------------------
-- View `stohtpsd_my_library`.`most_popular`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stohtpsd_my_library`.`most_popular`;
USE `stohtpsd_my_library`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stohtpsd_my_library`.`most_popular` AS select `stohtpsd_my_library`.`books`.`title` AS `title`,`stohtpsd_my_library`.`reviews`.`stars` AS `stars` from (`stohtpsd_my_library`.`books` join `stohtpsd_my_library`.`reviews`) where (`stohtpsd_my_library`.`reviews`.`stars` >= 4);
USE `stohtpsd_my_library`;

DELIMITER $$
USE `stohtpsd_my_library`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `stohtpsd_my_library`.`update_total_books_author`
AFTER INSERT ON `stohtpsd_my_library`.`books`
FOR EACH ROW
BEGIN
	UPDATE authors
		SET total_books = total_books + 1
		WHERE author_id = NEW.author_id;
END$$

USE `stohtpsd_my_library`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `stohtpsd_my_library`.`update_available_amount_books`
AFTER INSERT ON `stohtpsd_my_library`.`book_interactions`
FOR EACH ROW
BEGIN
	IF NEW.interaction_type = 'Borrowed' THEN
		UPDATE books
			SET available_amount = available_amount - 1
			WHERE book_id = NEW.book_id;
	END IF;
	IF NEW.interaction_type = 'Returned' THEN
		UPDATE books
			SET available_amount = available_amount + 1
			WHERE book_id = NEW.book_id;
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
