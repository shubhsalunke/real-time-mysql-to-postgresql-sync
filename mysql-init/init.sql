CREATE DATABASE inventory;
USE inventory;

CREATE TABLE customers (
 id INT PRIMARY KEY,
 first_name VARCHAR(255),
 last_name VARCHAR(255),
 email VARCHAR(255)
);

INSERT INTO customers VALUES
(1001,'Sally','Thomas','sally@example.com'),
(1002,'George','Bailey','george@example.com');

CREATE USER 'debezium'@'%' IDENTIFIED BY 'dbz';

GRANT SELECT, RELOAD, SHOW DATABASES,
REPLICATION SLAVE, REPLICATION CLIENT
ON *.* TO 'debezium'@'%';

FLUSH PRIVILEGES;
