CREATE DATABASE IF NOT EXISTS human_friends;
USE human_friends;

CREATE TABLE `animal_genus`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `genus` VARCHAR(30) NOT NULL,
    `animal_type_id` INT NOT NULL
);
CREATE TABLE `order`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `order_name` VARCHAR(30) NOT NULL,
    `definition` VARCHAR(255) NULL
);
CREATE TABLE `animal_type`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type` VARCHAR(30) NOT NULL
);
CREATE TABLE `animal`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `animal_name` VARCHAR(30) NULL,
    `birth_date` DATE NULL,
    `animal_genus_id` INT NOT NULL
);
CREATE TABLE `order_to`(
    `animal_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` INT NOT NULL,
    PRIMARY KEY(`order_id`)
);
ALTER TABLE
    `order_to` ADD CONSTRAINT `order_to_animal_id_foreign` FOREIGN KEY(`animal_id`) REFERENCES `animal`(`id`);
ALTER TABLE
    `order` ADD CONSTRAINT `order_id_foreign` FOREIGN KEY(`id`) REFERENCES `order_to`(`order_id`);
ALTER TABLE
    `animal_genus` ADD CONSTRAINT `animal_genus_animal_type_id_foreign` FOREIGN KEY(`animal_type_id`) REFERENCES `animal_type`(`id`);
ALTER TABLE
    `animal` ADD CONSTRAINT `animal_animal_genus_id_foreign` FOREIGN KEY(`animal_genus_id`) REFERENCES `animal_genus`(`id`);