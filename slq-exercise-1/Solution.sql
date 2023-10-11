-- create orders
CREATE TABLE Orders (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

-- create boards
CREATE TABLE Boards (
  id INTEGER PRIMARY KEY,
  `order` INTEGER NOT NULL,
  datetime TIMESTAMP  NOT NULL,
  length_mm DOUBLE NOT NULL,
  FOREIGN KEY (`order`) REFERENCES Orders(id)
);

-- create defects
CREATE TABLE Defects (
  board INTEGER ,
  description TEXT NOT NULL,
  FOREIGN KEY (board) REFERENCES Boards(id)
);

-- insert orders
INSERT INTO Orders VALUES (1,  'Order_1');
INSERT INTO Orders VALUES (2,  'Order_2');
INSERT INTO Orders VALUES (3,  'Order_3');
INSERT INTO Orders VALUES (4,  'Order_4');

-- insert Boards
INSERT INTO Boards VALUES (11, 1, '2023-01-01 07:00:00.000',  4200);
INSERT INTO Boards VALUES (8, 1,  '2023-01-01 07:00:00.430',  4250);
INSERT INTO Boards VALUES (10, 1, '2023-01-01 07:00:01.150',  4180);
INSERT INTO Boards VALUES (3, 1,  '2023-01-01 07:00:03.110',  4060);
INSERT INTO Boards VALUES (2, 2,  '2023-01-01 07:15:23.500',  3520);
INSERT INTO Boards VALUES (4, 2,  '2023-01-01 07:15:25.123',  3580);
INSERT INTO Boards VALUES (9, 2,  '2023-01-01 07:15:25.670 ', 3610);
INSERT INTO Boards VALUES (1, 2,  '2023-01-01 07:15:26.330',  3840);
INSERT INTO Boards VALUES (5, 3,  '2023-01-01 08:23:15.680',  5200);
INSERT INTO Boards VALUES (7, 3,  '2023-01-01 08:23:16.030',  5220);
INSERT INTO Boards VALUES (6, 4,  '2023-01-01 08:50:01.330',  4060);

-- insert defects
INSERT INTO Defects VALUES (4,  'Bark');
INSERT INTO Defects VALUES (4,  'Black knot');
INSERT INTO Defects VALUES (4,  'Wane');
INSERT INTO Defects VALUES (6,  'Knot');
INSERT INTO Defects VALUES (8,  'Bark');
INSERT INTO Defects VALUES (8,  'Knot');
INSERT INTO Defects VALUES (10,  'Split');

-- Create temp table to store results
CREATE TABLE result_table(
   order_id INTEGER PRIMARY KEY,
   order_name TEXT NOT NULL,
   no_boards INTEGER NOT NULL,
   no_boards_with_defects INTEGER NOT NULL,
   order_start TIMESTAMP NOT NULL,
   order_end TIMESTAMP NOT NULL,
   time_interval_to_previous_order_minutes INTEGER,
   sum_length_mm DOUBLE,
   avg_length_mm DOUBLE,
   stdev_length_mm DOUBLE,
   avg_time_interval_between_boards_milliseconds INTEGER
);

-- fetch  --(SELECT AVG(SELECT TIMESTAMPDIFF(MINUTE, LAG(datetime) OVER (ORDER BY datetime) , datetime) FROM Boards)) AS avg_time_interval_between_boards_milliseconds
INSERT INTO result_table(order_id, order_name, no_boards, no_boards_with_defects, order_start, order_end,sum_length_mm, avg_length_mm, stdev_length_mm,avg_time_interval_between_boards_milliseconds ) 
SELECT id AS order_id ,
       name AS order_name,
       (SELECT count(Boards.id) FROM Boards WHERE Boards.Order = Orders.id) AS no_boards,
       (SELECT count(DISTINCT Defects.board) FROM Defects WHERE Defects.board IN (SELECT Boards.id FROM Boards WHERE Boards.Order = Orders.id))  AS no_boards_with_defects,
       (SELECT MIN(Boards.datetime) FROM Boards WHERE Boards.Order = Orders.id) AS order_start,
       (SELECT MAX(Boards.datetime) FROM Boards WHERE Boards.Order = Orders.id) AS order_end,
       (SELECT SUM(Boards.length_mm) FROM Boards WHERE Boards.Order = Orders.id) AS sum_length_mm,
       (SELECT AVG(Boards.length_mm) FROM Boards WHERE Boards.Order = Orders.id) AS avg_length_mm,
       (SELECT STDDEV(Boards.length_mm) FROM Boards WHERE Boards.Order = Orders.id) AS stdev_length_mm,
       (SELECT AVG(t.time_diff) / 1000 FROM Boards, (SELECT TIMESTAMPDIFF(MICROSECOND, LAG(datetime) OVER (ORDER BY datetime) , datetime) AS time_diff FROM Boards WHERE Boards.Order = Orders.id) AS t) AS avg_time_interval_between_boards_milliseconds
       
FROM Orders;

-- This Adds the time_interval_to_previous_order_minutes using  window frame specification function lag (note)
UPDATE result_table AS r, ( SELECT order_id, TIMESTAMPDIFF(MINUTE, LAG(order_start) OVER (ORDER BY order_start) , order_start) AS time_interval FROM result_table) AS t
SET r.time_interval_to_previous_order_minutes = t.time_interval
WHERE r.order_id = t.order_id;

-- Show Final Results
SELECT * FROM result_table