CREATE DATABASE Populations;

USE Populations;

CREATE TABLE County_Population(
	county_code VARCHAR(45) NOT NULL,
    county_name VARCHAR(45) NOT NULL,
    date_year INT NOT NULL,
    race_code INT NOT NULL,
    race TEXT NOT NULL,
    gender VARCHAR(6) NOT NULL,
    age INT NOT NULL,
    population INT NOT NULL
);

/* Load Data */
LOAD DATA LOCAL INFILE
'D:/iNeuron/Assignment/SQL/Assignment 2 road safety/CA_DRU_proj_2010-2060 (1)/CA_DRU_proj_2010-2060.csv'
INTO TABLE County_Population
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* check the loaded data */
SELECT  * FROM County_Population
LIMIT 10;

-- Q:Which county has the highest population?--
SELECT county_name, sum(population) Tota_Population FROM County_Population
GROUP BY county_name
Order by Tota_Population Desc
Limit 1;

-- Which county has the least number of people?--
SELECT county_name, sum(population) Tota_Population FROM County_Population
GROUP BY county_name 
Order by Tota_Population Asc
Limit 1;

-- Which country is witnessing the highest population growth?--

WIth County_Pop AS (SELECT county_name,date_year, sum(population) Pop_by_year FROM County_Population
GROUP BY 1,2),
Growth_Pop AS (SELECT county_name,date_year, Pop_by_year, 
			Lead(Pop_by_year) Over(Partition by county_name Order by date_year) Next_yr_Pop FROM County_Pop)
SELECT county_name,date_year,Pop_by_year, round(((Next_yr_Pop-Pop_by_year)/Pop_by_year * 100),2) as Pop_Growth_Percent
		FROM Growth_Pop
        Order by Pop_Growth_Percent Desc
        Limit 1;


-- Which country has an extraordinary number for the population?--
SELECT county_name, sum(population) Tota_Population FROM County_Population
GROUP BY county_name
Order by Tota_Population Desc
Limit 10;														-- Top most extraordinary populated coumtry

/* area of county not given we can't calculate densily populated county
	concept population_density=(No_Of_people / Land_Area)	
