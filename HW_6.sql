# HW_6
/*
1. 
Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя из 
таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback - обязательно). 
*/
-- Создание таблицы users_old
CREATE TABLE users_old (
    id BIGINT UNSIGNED PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

-- Процедура для перемещения пользователя из users в users_old
DELIMITER //
CREATE PROCEDURE MoveUserToOldUserTable(IN userID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Unable to move user to old table';
    END;

    START TRANSACTION;
    INSERT INTO users_old (id, firstname, lastname, email)
    SELECT id, firstname, lastname, email
    FROM users
    WHERE id = userID;

    DELETE FROM users WHERE id = userID;

    COMMIT;
END;
//
DELIMITER ;

/*
2. 
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". 
*/
DELIMITER //
CREATE FUNCTION hello() RETURNS VARCHAR(50)
BEGIN
    DECLARE current_hour INT;
    DECLARE greeting VARCHAR(50);
    
    SET current_hour = HOUR(NOW());
    
    IF current_hour >= 6 AND current_hour < 12 THEN
        SET greeting = 'Доброе утро';
    ELSEIF current_hour >= 12 AND current_hour < 18 THEN
        SET greeting = 'Добрый день';
    ELSEIF current_hour >= 18 AND current_hour < 24 THEN
        SET greeting = 'Добрый вечер';
    ELSE
        SET greeting = 'Доброй ночи';
    END IF;
    
    RETURN greeting;
END;
//
DELIMITER ;

/*
3.
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, communities и messages в таблицу 
logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа.
*/
-- Создание таблицы logs типа Archive
CREATE TABLE logs (
    log_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    table_name VARCHAR(50),
    primary_key_id BIGINT UNSIGNED
) ENGINE = ARCHIVE;

-- Создание триггера для логирования
DELIMITER //
CREATE TRIGGER LogAfterInsert AFTER INSERT ON users FOR EACH ROW
BEGIN
    INSERT INTO logs (table_name, primary_key_id) VALUES ('users', NEW.id);
END;
//
DELIMITER ;
