CREATE database  Road_Safety_Uk;
USE Road_Safety_Uk;

/* Create Tables */
CREATE TABLE accident(
	accident_index VARCHAR(13),
    accident_severity INT
);

CREATE TABLE vehicles(
	accident_index VARCHAR(13),
    vehicle_type VARCHAR(50)
);

CREATE TABLE vehicle_types(
	vehicle_code INT,
    vehicle_type VARCHAR(50)
);

/* Load Data */
LOAD DATA LOCAL INFILE 'D:/iNeuron/Assignment/SQL/Assignment 2 road safety/accident.csv'
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES													-- we are loading only two columns froom csv file accident
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy,
 @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
 @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
 @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;

show global variables like 'local_infile';
set global local_infile=1;
LOAD DATA LOCAL INFILE 'D:/iNeuron/Assignment/SQL/Assignment 2 road safety/Vehicles.csv'
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_type=@col2;


LOAD DATA LOCAL INFILE 'D:/iNeuron/Assignment/SQL/Assignment 2 road safety/Vehicle_type.csv'
INTO TABLE vehicle_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
Select * FROM vehicle_types;

/* ----Show all tables in database----------- */
show tables;
SELECT * FROM accident;
SELECT * FROM vehicle_types;
SELECT * FROM vehicles;

/*----Q1: Evaluate the median severity value of accidents caused by various Motorcycles.*/

WITH All_Data AS (SELECT accident_severity  FROM  accident a
JOIN vehicles v ON a.accident_index=v.accident_index
JOIN vehicle_types vt ON v.vehicle_type=vt.vehicle_code),
All_data_rank AS (SELECT accident_severity, dense_rank() over(Order by accident_severity Asc) asc_accident_severity,
						dense_rank() over(Order by accident_severity DESC) desc_accident_severity
FROM All_Data)
SELECT avg(accident_severity) FROM All_data_rank
WHERE asc_accident_severity IN (desc_accident_severity,desc_accident_severity+1,desc_accident_severity-1);

/* ---Q2:Evaluate Accident Severity and Total Accidents per Vehicle Type.--*/
SELECT accident_Severity, vt.vehicle_type as Vehicle_type, count(vt. vehicle_type) No_Of_Accident  FROM  accident a
JOIN vehicles v ON a.accident_index=v.accident_index
JOIN vehicle_types vt ON v.vehicle_type=vt.vehicle_code
GROUP BY 1,2;

/* ---Q3: Calculate average severity by vehicle type--*/
SELECT vt.vehicle_type as Vehicle_type, avg(accident_severity) as Average_Severity FROM  accident a
JOIN vehicles v ON a.accident_index=v.accident_index
JOIN vehicle_types vt ON v.vehicle_type=vt.vehicle_code
GROUP BY vt.vehicle_type;

/* ---Q4: Calculate the Average Severity and Total Accidents by Motorcycle.--*/
SELECT vt.vehicle_type as Vehicle_type, avg(accident_severity) as Average_Severity, 
count(vt.vehicle_type) as Totol_Accident FROM  accident a
JOIN vehicles v ON a.accident_index=v.accident_index
JOIN vehicle_types vt ON v.vehicle_type=vt.vehicle_code
WHERE lower(vt.Vehicle_type) Like '%motorcycle%'
GROUP BY Vehicle_type;



