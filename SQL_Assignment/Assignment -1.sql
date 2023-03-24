CREATE DATABASE Hiring_ABC;
Use Hiring_ABC;

-- Creating a table
CREATE TABLE Shopping_History (Product varchar(30) not null,
								Quantity Int not null,
                                Unit_price integer not null);

-- record inserting in table
INSERT INTO Shopping_History values('Milk',3,10),('Bread',7,3),('Bread',5,2);
-- show records in table
SELECT * FROM Shopping_History ;

/* Write SQL Query that for each 'Product', return the total amount of money spent on it. Rows should be 
Ordered by Descending  alphabet order by 'Product' */
SELECT Product, sum(Quantity*Unit_price) AS Total_Price FROM Shopping_History 
GROUP BY Product
Order by Product Desc;

--  Creating a table for telecommunication company--

CREATE Table phones(name varchar(20) Not Null unique,
					phone_number integer not null unique
					);

CREATE TABLE calls (id integer not null,
					caller integer not null,
                    callee integer not null,
                    duration integer not null,
                    Unique(ID)					
                    );
                    
-- Inserting values in tables
INSERT INTO phones values('Jack',1234),('Lena',3333),('Mark',9999),('Anna',7582);
INSERT INTO calls values(25,1234,7582,8),(7,9999,7582,1),(18,9999,3333,4),
						(2,7582,3333,3),(3,3333,1234,1),(21,3333,1234,1);
SELECT * FROM phones;
SELECT * FROM calls;

-- Write a query to finds all clients who talked for at least 10 minutes in total --
SELECT Name  FROM (
SELECT name, sum(duration) Talked_Time FROM phones p
JOIN Calls c ON p.phone_number=c.caller
GROUP BY name
Union
SELECT name, sum(duration) Talked_Time FROM phones p
JOIN Calls c ON p.phone_number=c.callee
GROUP BY name) X
GROUP BY name
Having sum(Talked_Time)>=10;

-- Creating table2 ----
CREATE Table phones2 (name varchar(20) Not Null unique,
					phone_number integer not null unique
					);

CREATE TABLE calls2 (id integer not null,
					caller integer not null,
                    callee integer not null,
                    duration integer not null,
                    Unique(ID)					
                    );
-- Inserting values--
INSERT INTO phones2 values('Jack',6356),('Addison',4315),('Kate',8003),('Ginny',9831);
INSERT INTO calls2 values(65,8003,9831,7),(100,9831,8003,3),(145,4315,9831,18);
SELECT * FROM phones2;
SELECT * FROM calls2;

SELECT Name FROM (
SELECT name, c.duration talk_time FROM phones2 P
JOIN calls2 c ON p.phone_number=c.caller
UNION
SELECT name, c2.duration talk_time FROM phones2 P
JOIN calls2 c2 ON p.phone_number=c2.callee
) Inner_Query
GROUP BY name
Having sum(talk_time)>=10
Order by 1;

-- Task 3 Creating table for transactions--
CREATE TABLE Transactions (amount integer not null,
							dates Date not null);
						
Insert into Transactions values (1000,'2020/01/06'),(-10,'2020/01/14'),(-75,'2020/01/20'),(-5,'2020/01/25'),
							(-4,'2020/01/29'),(2000,'2020/03/10'),(-75,'2020/03/12'),(-20,'2020/03/15'),
                            (40,'2020/03/15'),(-50,'2020/03/17'), (200,'2020/10/10'),(-200,'2020/10/10');
SELECT * FROM Transactions;

        
SELECT sum(amount)-(11*5) as Balance FROM Transactions;
-- Output 2746

-- Creating table 2 transaction--
CREATE TABLE Transactions2 (amount integer not null,
							dates Date not null);
						
Insert into Transactions2 values (1,'2020/06/29'),(35,'2020/02/20'),(-50,'2020/02/03'),(-1,'2020/02/26'),
							(-200,'2020/08/01'),(-44,'2020/02/07'),(-5,'2020/02/25'),(1,'2020/06/29'),
                            (1,'2020/06/29'),(-100,'2020/12/29'), (-100,'2020/12/30'),(-100,'2020/12/31');

SELECT * FROM Transactions2;

SELECT sum(amount)-(10*5) Balance FROM Transactions2;
-- Output -612

-- Creating table 3 transaction
CREATE TABLE Transactions3 (amount integer not null,
							dates Date not null);
						
Insert into Transactions3 values (6000,'2020-04-03'),(5000,'2020-04-02'),(4000,'2020-04-01'),(3000,'2020-03-01'),
							(2000,'2020-02-01'),(1000,'2020-01-01');

Select * FROM Transactions3;

SELECT sum(amount)-(6*5) FROM Transactions3;			-- No credit card charges





