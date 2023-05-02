USE home_work_05;

CREATE TABLE Cars (
id INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(20),
Cost INT NOT NULL
);

INSERT INTO Cars(Name, Cost) VALUES 
('Audi', 52642),
('Mercedes', 57127),
('Skoda', 9000),
('Volvo', 29000),
('Bentley', 350000),
('Citroen', 21000),
('Hummer', 41400),
('Volkswagendi', 21600);

SELECT * FROM Cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE VIEW Cars_1 AS
SELECT * FROM Cars
WHERE Cost < 25000;
SELECT * FROM Cars_1;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW Cars_1 AS
SELECT * FROM Cars
WHERE Cost < 30000;
SELECT * FROM Cars_1;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW Cars_3 AS
SELECT * FROM Cars
WHERE Name = 'Skoda' OR Name = 'Audi';
SELECT * FROM Cars_3;

CREATE TABLE Analysis(
an_id INT AUTO_INCREMENT PRIMARY KEY,
an_name VARCHAR(20),
an_cost INT NOT NULL,
an_price INT NOT NULL,
an_group VARCHAR(20)
);

INSERT INTO Analysis(an_name, an_cost, an_price, an_group) VALUES 
('Groop_blood', 500, 1000, 'QQW'),
('Bio_chem', 2000, 3500, 'QAW'),
('ALT', 200, 700, 'QWE'),
('AST', 300, 800, 'QWE'),
('Corona', 3000, 7000, 'QSW');

CREATE TABLE Groops(
gr_id INT AUTO_INCREMENT PRIMARY KEY,
gr_name VARCHAR(20),
gr_temp INT NOT NULL
);

INSERT INTO Groops(gr_name, gr_temp) VALUES 
('QQW', 20),
('QAW', 20),
('QWE', 5),
('QSW', 10);

CREATE TABLE Orders(
ord_id INT AUTO_INCREMENT PRIMARY KEY,
ord_datetime DATETIME,
FOREIGN KEY (ord_id) REFERENCES Analysis(an_id) ON DELETE CASCADE
);

INSERT INTO Orders(ord_datetime) VALUES 
('2020-02-03 12:30:22'),
('2020-02-05 11:50:44'),
('2020-02-06 15:40:12'),
('2020-02-16 16:23:52');

-- 4. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

SELECT an_name, an_price, ord_datetime
FROM Analysis
JOIN Orders
ON Analysis.an_id = Orders.ord_id
AND Orders.ord_datetime >= '2020-02-05'
AND Orders.ord_datetime <= '2020-02-12';

CREATE TABLE trains_station (
train_id INT NOT NULL,
station VARCHAR(20),
station_time TIME
);

INSERT INTO trains_station(train_id, station, station_time) VALUES
(110, 'SanFrancisco', '10:00:00'),
(110, 'RedwoodCity', '10:54:00'),
(110, 'PaloAlto', '11:02:00'),
(110, 'SanJose', '12:35:00'),
(120, 'SanFrancisco', '11:00:00'),
(120, 'PaloAlto', '12:49:00'),
(120, 'SanJose', '13:30:00');

SELECT *,
TIMEDIFF(LEAD(station_time, 1) OVER(PARTITION BY train_id ORDER BY train_id), station_time)
AS time_to_next_station
FROM trains_station;




