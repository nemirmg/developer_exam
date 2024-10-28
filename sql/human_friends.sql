CREATE DATABASE IF NOT EXISTS human_friends;
USE human_friends;

CREATE TABLE `animal_type`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `animal_genus`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `genus` VARCHAR(30) NOT NULL,
    `animal_type_id` INT NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`animal_type_id`) REFERENCES `animal_type`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `animal`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `animal_name` VARCHAR(30) NULL,
    `birth_date` DATE NULL,
    `animal_genus_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`animal_genus_id`) REFERENCES `animal_genus`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `order`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `order_name` VARCHAR(30) NOT NULL,
    `definition` VARCHAR(255) NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `order_to`(
    `animal_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    PRIMARY KEY(`animal_id`, `order_id`),
    FOREIGN KEY(`animal_id`) REFERENCES `animal`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`order_id`) REFERENCES `order`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `animal_type`(`type`)
VALUES ('Домашние животные'),
       ('Вьючные животные');

INSERT INTO `animal_genus`(`genus`, `animal_type_id`)
VALUES ('Хомяк', 1),
       ('Кошка', 1),
       ('Собака', 1),
       ('Осёл', 2),
       ('Лошадь', 2),
       ('Верблюд', 2);

INSERT INTO `animal`(`animal_name`, `birth_date`, `animal_genus_id`)
VALUES ('Шарик', '2020-10-08', 3),
       ('Мурка', '2011-01-01', 2),
       ('Илларион', '2024-05-19', 1),
       ('Жучка', '2018-02-13', 3),
       ('Батон', '2021-11-02', 2),
       ('Фрося', '2023-07-14', 1),
       ('Тихон', '2019-04-01', 5),
       ('Буря', '2017-03-07', 5),
       ('Паша', '2009-01-01', 6),
       ('Ласточка', '2015-06-30', 6),
       ('Мопед', '2018-01-19', 4),
       ('Серена', '2018-04-28', 4);

INSERT INTO `order`(`order_name`, `definition`)
VALUES ('Апорт', 'Словом "апорт" мы обязаны французскому языку. В оригинале оно пишется так: apport. Переводится очень просто - принеси!'),
       ('Фас', 'Первоисточник следует искать в немецком языке. Там есть такое слово, как fassen, что означает "Хватай!".'),
       ('Кис-кис', 'Подозвать животное.'),
       ('Но!', 'Начать движение.'),
       ('Шагом', 'Перейти на шаг.'),
       ('Брысь', null),
       ('Вниз', 'Опуститься на колени'),
       ('Стой', null);

INSERT INTO `order_to`(`animal_id`, `order_id`)
VALUES (1, 1), (1, 2),
       (2, 6),
       (4, 1),
       (5, 3), (5, 6),
       (6, 8),
       (7, 4), (7, 8),
       (8, 4), (8, 5), (8, 8),
       (10, 4), (10, 7),
       (11, 4), (11, 8),
       (12, 6);

DELETE FROM `animal`
 WHERE `animal_genus_id` = (SELECT `id`
                              FROM `animal_genus`
					         WHERE `genus` = 'Верблюд');

CREATE TABLE `ungulate` AS
SELECT *
  FROM `animal`
 WHERE `animal_genus_id` IN (SELECT `id`
                               FROM `animal_genus`
							  WHERE `genus` IN ('Осёл', 'Лошадь'));

CREATE TABLE `young_animal` AS
SELECT *, 
       TIMESTAMPDIFF(MONTH, `birth_date`, CURDATE()) AS `age_month`
  FROM `animal` 
 WHERE `birth_date` < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
       AND
       `birth_date` > DATE_SUB(CURDATE(), INTERVAL 3 YEAR);
