--9

/*
INSERT INTO city (City)
select distinct city, 'SVE' from Customers
Where city NOT IN
			(
			SELECT City from city
			)
			
--10


SELECT COUNT(*) FROM City
WHERE city = 'stockholm'

SELECT city,count(*) from city
group by city 
Having count(*) > 1

--10
/*
set all populations in country table so that sum of population of different citiesfrom city table
/*

UPDATE Country
SET country.population = (
	SELECT SUM(population) from city
	WHERE country.CountryId = city.CountryId
	)
BEGIN TRANSACTION

--1
/*
INSERT INTO country (CountryId, Country, Population, Government)
VALUES ('BRA','Brasilien',140000000,'Demokrati')

SELECT * FROM country
*/

--2
/*
INSERT INTO city (City, Population)
VALUES ('Rio de Janeiro', 10000000)

SELECT * FROM city
*/

--3
/*
INSERT INTO city
VALUES ('Umeå','SWE',40000),
('Norrköping','SWE',115000),
('Örebro','SWE',90000)

SELECT * FROM city
*/

--4
/*
UPDATE country
SET CountryId = 'SVE'
WHERE CountryId = 'SWE'

UPDATE city
SET CountryId = 'SVE'
WHERE CountryId = 'SWE'


--5
UPDATE country
SET Population = 3900000
WHERE Population IS NULL

UPDATE city
SET Population = 275500
WHERE Population IS NULL


SELECT * FROM country
*/

--6
/*
Update country
SET population = population * 2
WHERE population <> 0

Update city
SET population = population * 2
 WHERE population <> 0

--7

INSERT INTO city (City)
SELECT City FROM Customers 
*/

--8
/*
DELETE FROM city
WHERE Population is NULL
AND city IN (SELECT DISTINCT City FROM Customers)
AND COUNTRY 
*/

--9
/*
INSERT INTO city (City)
select distinct city, 'SVE' from Customers
Where city NOT IN (
			SELECT City from city
			)

--OR

INSERT INTO city (City)
SELECT DISTINCT City from Customers
WHERE customers.City <> (SELECT City FROM city)

*/
--10
