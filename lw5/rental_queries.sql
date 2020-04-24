-- 3.  Подготовьте SQL запросы для заполнения таблиц данными.#10
INSERT INTO dvd (title, production_year)
VALUES ('Побег из Шоушенка', 1994),
       ('Форрест Гамп', 1994),
       ('1 + 1', 2011),
       ('Бойцовский клуб', 1999),
       ('Крестный отец', 1972);

INSERT INTO customer (first_name, last_name, passport_code, registration_date)
VALUES ('Иван', 'Иванов', '123456', '2000-02-14'),
       ('Петр', 'Петров', '123789', '1992-06-08'),
       ('Дмитрий', 'Дмитриев', '123100', '1996-11-23');

INSERT INTO offer (dvd_id, customer_id, offer_date, return_date)
VALUES (2, 1, '2020-01-01', '2020-02-01'),
       (3, 2, '2020-01-01', '2020-02-01'),
       (5, 3, '2020-01-01', '2020-02-01');
-- 4.  Подготовьте SQL запрос получения списка всех DVD, год выпуска которых 2010, отсортированных в алфавитном порядке по названию DVD. #10

SELECT *
FROM dvd
WHERE production_year = 1994
ORDER BY title ASC;

-- 5.  Подготовьте SQL запрос для получения списка DVD дисков, которые в настоящее время находятся у клиентов. #10

SELECT dvd.*
FROM offer
    LEFT JOIN dvd ON dvd.dvd_id = offer.dvd_id
WHERE CURRENT_DATE BETWEEN offer.offer_date AND offer.return_date;
