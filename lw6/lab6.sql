--1. (#15)  Напишите SQL запросы  для решения задач ниже.  
CREATE TABLE pc (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	cpu INTEGER NOT NULL,
	memory INTEGER NOT NULL,
	hdd INTEGER NOT NULL
);

INSERT INTO pc (cpu, memory, hdd) VALUES (1600, 2000, 500);
INSERT INTO pc (cpu, memory, hdd) VALUES (2400, 3000, 800);
INSERT INTO pc (cpu, memory, hdd) VALUES (3200, 3000, 1200);
INSERT INTO pc (cpu, memory, hdd) VALUES (2400, 2000, 500);

--Тактовые частоты CPU тех компьютеров, у которых объем памяти 3000 Мб. Вывод: id, cpu, memory
SELECT id, cpu, memory
FROM pc
WHERE memory = 3000;

--Минимальный объём жесткого диска, установленного в компьютере на складе. Вывод: hdd.
SELECT MIN(hdd) AS min_hdd
FROM pc;

--Количество компьютеров с минимальным объемом жесткого диска, доступного на складе. Вывод: count, hdd.
SELECT COUNT(*) AS count, hdd
FROM pc
WHERE hdd IN (SELECT MIN(hdd) FROM pc);

--6 task. Как удалить повторяющиеся строки с использованием ключевого слова Distinct? Приведите пример таблиц с данными и запросы. 

--SELECT DISTINCT columns FROM table; 
--где: 
--columns - имена столбцов, для которых рассматривается уникальность;
--table - имя таблицы, из которой выбираются эти столбцы.

--Если запрос содержит более 1 столбца, то уникальность записи определяется комбинацией всех 
--соответствующих значений.
--DISTINCT считает дубликатами значения NULL, поэтому всегда возвращается одно значение NULL.

--Для примера создам таблицу people:
CREATE TABLE people (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	years_old INTEGER NOT NULL
);

INSERT INTO people (name, years_old) VALUES ('Петров', 20);
INSERT INTO people (name, years_old) VALUES ('Смирнов', 35);
INSERT INTO people (name, years_old) VALUES ('Сидоров', 40);
INSERT INTO people (name, years_old) VALUES ('Петров', 40);

-- Запрос вернет три значения из четырех существующих: Петров, Смирнов, Сидоров
SELECT DISTINCT name FROM people;
-- Запрос вернет все четыре значения: Петров - 20, Смирнов - 35, Сидоров - 40, Петров - 40
SELECT DISTINCT name, years_old FROM people;


--7 task
--Есть две таблицы:
--     users - таблица с пользователями (users_id, name)
--    orders - таблица с заказами (orders_id, users_id, status)
--    1) Выбрать всех пользователей из таблицы users, у которых ВСЕ записи в таблице orders имеют status = 0
--    2) Выбрать всех пользователей из таблицы users, у которых больше 5 записей в таблице orders имеют status = 1

CREATE TABLE users (
	users_id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL
);

CREATE TABLE orders (
	orders_id INTEGER PRIMARY KEY AUTOINCREMENT,
	users_id INTEGER NOT NULL, 
	status INTEGER NOT NULL,
	FOREIGN KEY(users_id) REFERENCES users(users_id)
);

INSERT INTO users (name) VALUES ('Петр');
INSERT INTO users (name) VALUES ('Сергей');
INSERT INTO users (name) VALUES ('Иван');

INSERT INTO orders (users_id, status) VALUES (1, 1);
INSERT INTO orders (users_id, status) VALUES (1, 1);
INSERT INTO orders (users_id, status) VALUES (1, 0);
INSERT INTO orders (users_id, status) VALUES (2, 0);
INSERT INTO orders (users_id, status) VALUES (2, 0);
INSERT INTO orders (users_id, status) VALUES (3, 0);
INSERT INTO orders (users_id, status) VALUES (4, 1);
INSERT INTO orders (users_id, status) VALUES (4, 0);

--Выбрать всех пользователей из таблицы users, у которых ВСЕ записи в таблице orders имеют status = 0
SELECT DISTINCT users.users_id, users.name
FROM users
INNER JOIN orders ON orders.users_id = users.users_id
WHERE users.users_id NOT IN ( 
	SELECT users_id
	FROM orders
	WHERE status != 0
);

--Выбрать всех пользователей из таблицы users, у которых больше 5 записей в таблице orders имеют status = 1
SELECT users.users_id, name, COUNT(*) AS number_of_orders
FROM users
INNER JOIN orders ON users.users_id = orders.users_id
WHERE status = 1
GROUP BY orders.users_id
HAVING number_of_orders > 5;
