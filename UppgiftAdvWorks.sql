/*
1.
Du ska ta fram ett skript för få fram en telefonlista för samtliga anställda. Listan ska bestå av dessa kolumner: Efternamn, Förnamn, Telefonnummer.  
Listan ska i första hand vara sorterad på Efternamn och i andra hand på Förnamn. Om en person har flera telefonnummer (typ arbetsnummer, mobilnummer eller hemnummer) så kommer samma person ha flera rader i listan*/

SELECT
	TblPer.LastName AS Efternamn,
	TblPer.Firstname AS Förnamn,
	TblPerPhn.PhoneNumber AS Telefonnummer
FROM
	Person.Person AS TblPer
	
LEFT JOIN HumanResources.Employee AS TblEmp
	ON TblPer.BusinessEntityID = TblEmp.BusinessEntityID
	
RIGHT JOIN Person.PersonPhone AS TblPerPhn
	ON TblPer.BusinessEntityID = TblPerPhn.BusinessEntityID
	
WHERE DBPer.BusinessEntityID = DBEmp.BusinessEntityID
ORDER BY Efternamn, Förnamn

/*
2.
Din chef kom på att det kan vara bra med epost-adresser också. Du ska göra ett separat skript där du även har med kolumnen Epost-adress. Använd samma sortering som uppgift 1.*/

SELECT
	TblPer.LastName AS Efternamn,
	TblPer.Firstname AS Förnamn,
	TblPerPhn.PhoneNumber AS Telefonnummer,
	TblEmail.EmailAddress AS [Epost-Adress]
FROM
	Person.Person AS TblPer
LEFT JOIN HumanResources.Employee AS TblEmp
	ON TblPer.BusinessEntityID = TblEmp.BusinessEntityID
	
RIGHT JOIN Person.PersonPhone AS TblPerPhn
	ON TblPer.BusinessEntityID = TblPerPhn.BusinessEntityID
	
RIGHT JOIN Person.EmailAddress as TblEmail
	ON TblPer.BusinessEntityID = TblEmail.BusinessEntityID
	
WHERE TblPer.BusinessEntityID = TblEmp.BusinessEntityID
ORDER BY Efternamn, Förnamn

/*
3.
Din chef kom på att det kan vara bra att veta namnet på avdelningen också. Du ska göra ett separat skript där du även har med kolumnen Avdelning-adress. Sortering som Avdelning, Efternamn, Förnamn.*/

SELECT
	TblDept.Avdelning,
	TblPer.LastName AS Efternamn,
	TblPer.Firstname AS Förnamn,
	TblPerPhn.PhoneNumber AS Telefonnummer,
	TblEmail.EmailAddress AS [Epost-Adress]
FROM
	Person.Person AS DBPer
LEFT JOIN
HumanResources.Employee AS TblEmp
ON TblPer.BusinessEntityID = TblEmp.BusinessEntityID
	
RIGHT JOIN
Person.PersonPhone AS TblPerPhn
ON TblPer.BusinessEntityID = TblPerPhn.BusinessEntityID
	
RIGHT JOIN
Person.EmailAddress as TblEmail
ON TblPer.BusinessEntityID = TblEmail.BusinessEntityID
	
LEFT JOIN
	(
	SELECT
			Dept.[Name] AS Avdelning,
			DeptHist.BusinessEntityID as ID
			FROM HumanResources.Department as Dept
			LEFT JOIN HumanResources.EmployeeDepartmentHistory AS DeptHist
			ON Dept.DepartmentID = DeptHist.DepartmentID
	) AS TblDept
ON
TblDept.ID = TblPer.BusinessEntityID
	
WHERE TblPer.BusinessEntityID = TblEmp.BusinessEntityID 
ORDER BY Avdelning,LastName,FirstName


/*
4.
Din chef tänkte att det kanske ser konstigt ut med flera rader för samma person. Skapa ytterligare ett nytt skript som ger ett bredare svar istället, som ser ut ungefär som nedan. Om en viss person exempelvis skulle ha flera hemtelefonnummer så räcker det med att visa ett av dessa hemtelefonnummer. Samma gäller arbete, mobil och epost.*/

SELECT
	TblDept.Avdelning,
	TblPer.LastName AS Efternamn,
	TblPer.Firstname AS Förnamn,
	TblArbete.Arbete AS Arbete,
	TblMobil.Mobil as Mobil,
	TblHem.Hem as Hem,
	TblEmail.EmailAddress AS [Epost-Adress]
FROM
	Person.Person AS TblPer
	
LEFT JOIN
HumanResources.Employee AS TblEmp
ON
TblPer.BusinessEntityID = TblEmp.BusinessEntityID
	
RIGHT JOIN
Person.EmailAddress AS TblEmail
ON
TblPer.BusinessEntityID = TblEmail.BusinessEntityID
	
LEFT JOIN
	(
	SELECT
		Dept.[Name] AS Avdelning,
		DeptHist.BusinessEntityID AS ID
	FROM
		HumanResources.Department AS Dept
	LEFT JOIN
		HumanResources.EmployeeDepartmentHistory AS DeptHist
	ON
	Dept.DepartmentID = DeptHist.DepartmentID
	) AS TblDept
ON
TblDept.ID = TblPer.BusinessEntityID

LEFT JOIN (
	SELECT 
		PhoneNumber AS Arbete,
		BusinessEntityID
	FROM
		Person.PersonPhone AS PhnArbete
	WHERE
		PhoneNumberTypeID = 3) AS TblArbete
ON
TblArbete.BusinessEntityID = TblPer.BusinessEntityID

LEFT JOIN
	(
	SELECT 
		PhoneNumber AS Mobil,
		BusinessEntityID
	FROM
		Person.PersonPhone AS PhnMobil
	WHERE
		PhoneNumberTypeID = 2
	) AS TblMobil
ON
TblMobil.BusinessEntityID = TblPer.BusinessEntityID 

LEFT JOIN
	(
	SELECT 
		PhoneNumber AS Hem,
		BusinessEntityID
	FROM
		Person.PersonPhone AS PhnHem
	WHERE
		PhoneNumberTypeID = 1
	) AS TblHem
ON
TblHem.BusinessEntityID = TblPer.BusinessEntityID
 
WHERE
	TblPer.BusinessEntityID = TblEmp.BusinessEntityID 
ORDER BY
	Avdelning,LastName,FirstName


/*
5.
Din chef tycker att personalen är borta mycket, många timmar som försvinner som sjukdomar. Han vill att du fram ett skript som visar medelvärdet på sjuktimmar som finns registrerat.*/

SELECT 
	Sjuktimmar = AVG(SickleaveHours)
FROM
	HumanResources.Employee


/*
6.
Din chef kom på att detta skript inte gav så jättemycket… Han vill att du tar fram medelvärdet på sjuktimmar igen, men denna gång baserat på vilket år personen är född. Det ska sorteras på sjuktimmars medelvärde i fallande ordning i första hand och på år i andra hand*/

SELECT
   Datepart(yy,BirthDate) AS 'Född år',
   Gender AS 'Kön',
   Sjuktimmar = AVG(SickLeaveHours)
FROM
	HumanResources.Employee
GROUP BY
	Datepart(yy,BirthDate)
ORDER BY
	Sjuktimmar DESC,
	'född år' DESC 

/*
7.
Din chef vill nu att du tar fram medelvärdet på sjuktimmar igen, denna gång baserat på vilket år personen är född men även med kön. Det ska sorteras på sjuktimmars medelvärde i fallande ordning i första hand, på år i andra hand och kön i tredje hand*/

SELECT
   Datepart(yy,BirthDate) AS 'Född år',
   Gender AS 'Kön',
   Sjuktimmar = AVG(SickLeaveHours)
FROM
	HumanResources.Employee
GROUP BY
	Datepart(yy,BirthDate), Gender
ORDER BY
	Sjuktimmar DESC,
	'född år'DESC,
	Kön DESC  

/*
8.
Ditt företag kommer köra igång ett system för Business Intelligence. Det ska bli ett enkelt Star Schema. För att förse detta system med data så vill din chef att du tar fram några skript
A.
Skript för att skapa en ny, tom databas vid namn AdvWorksDW. När databasen AdvWorksDW finns på plats ska tomma tabeller, relationer och constraints såsom primary key och foreign key skapas. Du får välja lämplig datatyp i respektive kolumn själv. OBS! Detta skript ska alltså bara köras en gång*/

CREATE DATABASE AdvWorksDW
GO

USE AdvWorksDW
GO 

CREATE TABLE SalesPersonDim
 (
 SalesPersonID int NOT NULL PRIMARY KEY,
 Fullname nvarchar(100),
)

CREATE TABLE ProductDim (
 ProductID int NOT NULL PRIMARY KEY,
 ProductName nvarchar(100),
)

CREATE TABLE TerritoryDim (
 TerritoryID int NOT NULL PRIMARY KEY,
 Name nvarchar(100),
)

CREATE TABLE DateDim (
 DateID date NOT NULL PRIMARY KEY,
 [Year] int,
 [Month] int,
 Weekday int,
 WeekdayName nvarchar(25),
 Week int,
 [Day] int,
 Quarter int,
 QuarterName char(2),
)

CREATE TABLE SalesFact (
 SalesFactID int IDENTITY(1,1) PRIMARY KEY,
 SalesPersonID int FOREIGN KEY REFERENCES SalesPersonDim(SalesPersonID),
 ProductID int FOREIGN KEY REFERENCES ProductDim(ProductID),
 TerritoryID int FOREIGN KEY REFERENCES TerritoryDim(TerritoryID),
 OrderDateID date FOREIGN KEY REFERENCES DateDim(DateID),
 Quantity int,
 Sales money,
 Profit money,
 loadtime datetime,
)
GO

/*
B.
Skript för fylla i historisk data in i ovanstående tabeller. OBS! Detta historik-skript ska också bara köras på en gång, därefter ska all historik finnas på plats*/

--fylla SalespersonDim

INSERT INTO SalesPersonDim (SalesPersonID, Fullname)
	SELECT
		SalespersonTbl.BusinessEntityID AS SalesPersonID,
		FirstName + ' ' + LastName AS Fullname
	FROM
	AdventureWorks2017.sales.salesperson AS SalespersonTbl
	INNER JOIN
	AdventureWorks2017.person.person AS personTbl
	ON
	SalesPersonTbl.BusinessEntityID = personTbl.BusinessEntityID


--fylla productdim

INSERT INTO ProductDim( ProductID, ProductName )
	SELECT 
		ProductID,
		Name
	FROM
	AdventureWorks2017.production.product

--fylla TerritoryDim

INSERT INTO TerritoryDim(TerritoryID, Name)
	SELECT
		TerritoryID,
		[group] + ' - ' + Name as GroupName
	FROM
	AdventureWorks2017.sales.salesTerritory
	
--fylla DateDim

DECLARE @cnt int=0
DECLARE @start date 
DECLARE @NoOfDays int
DECLARE @date date

SELECT @start = min(OrderDate) FROM AdventureWorks2017.sales.salesOrderHeader
SELECT @NoOfDays = datediff(dd, @start, getdate())

SET DATEFIRST 1  --  Möndag som Week Start as 1

WHILE (@cnt < @NoOfDays) 
BEGIN
	SELECT @date = DATEADD(day, @cnt, @start)
    
	INSERT INTO [DateDim] (
		DateID, 
		[Year] , 
		[Month], 
		Weekday, 
		WeekdayName , 
		Week, 
		[Day] , 
		Quarter, 
		QuarterName 
		)  
	VALUES (
		@date, 
		datepart(year, @date), 
		datepart(month, @date),  
		datepart(weekday, @date), 
		datename(weekday, @date), 
		datepart(week, @date),
		datepart(day, @date), 
		datepart(Q, @date),
		'Q' + cast(datename(Q, @date) as char(1))
		)
    SET @cnt +=1
END
	
--fylla SalesFact

DECLARE @current_load_time datetime = GETDATE()

INSERT INTO SalesFact(SalesPersonID, ProductID, TerritoryID, OrderDateID, Quantity, Sales, Profit, Loadtime)
SELECT
	SOH.SalesPersonID,
	SOD.ProductID,
	SOH.TerritoryID,
	CAST(SOH.OrderDate AS DATE) as 'OrderDateID',
	SOD.OrderQty,
	SOD.OrderQty * SOD.Unitprice as Sales,

	-- Ta sales minus Produktionens Kostnad *

	(SOD.OrderQty * SOD.Unitprice)
	 -
	(SOD.OrderQty *	(
					SELECT
					PCH.Standardcost
					FROM 
					AdventureWorks2017.Production.ProductCostHistory as PCH
					WHERE SOH.OrderDate BETWEEN StartDate AND ISNULL(EndDate,GETDATE())
					AND PCH.ProductID = SOD.ProductID
					)) AS Profit,
					
	-- fylla loadtime column med current_load_time

	@current_load_time AS Loadtime
	
FROM
	AdventureWorks2017.sales.salesOrderHeader AS SOH
INNER JOIN 
	AdventureWorks2017.sales.salesOrderDetail AS SOD
ON SOH.salesOrderID = SOD.salesOrderID
		
/*
C.
Skript för att komplettera ovanstående tabeller med ny data. Detta skript är tänkt att köras varje natt och då enbart fylla på med nytillkomna poster. Du ska alltså INTE göra ett skript som tömmer tabellerna och gör om allt från början, utan det ska bara fylla på ny data.

Skriptet bör vara så ”fiffigt” att det fungerar även om skriptet inte körs varje natt, utan ska kunna köras var tredje dag, en gång i veckan eller liknande.  
Om du behöver, så får du fritt skapa separata tabeller för att ha koll på vilket data som redan finns i tabellerna i AdvWorksDW (så det inte blir dubbletter någonstans.

Skriv gärna en kommentar intill syntaxen för att tabellen skapas så jag vet vad tabellen är till för. Du får INTE lägga till tabeller i AdventureWorks2017-databasen.
 
Om du behöver, så får du fritt skapa extra kolumner i faktatabellerna och/eller i dimensionstabellerna. Detta alltså om du behöver för att ha koll på vilket data som redan finns i tabellerna (så det inte blir dubbletter någonstans).

Skriv en kommentar intill syntaxen för när kolumnen skapas så jag vet vad den är till för. Du får INTE ändra någon lägga till någon kolumn i tabellerna som finns i AdventureWorks2017-databasen.
*/

--INSERT NY DATA SKRIPT- BATCH FIL
--INTE UPDATE/FÖRÄNDRA HISTORISK DATA
--FÖRST FYLLA NYA RADER PÅ DEMENSIONER

DECLARE @current_load_time datetime = GETDATE()

-- SalesPersonDIM

INSERT INTO AdvWorksDW.dbo.SalesPersonDim (SalesPersonID, Fullname)
	SELECT
		SalespersonTbl.BusinessEntityID AS SalesPersonID,
		FirstName + ' ' + LastName AS Fullname
	FROM
	AdventureWorks2017.sales.salesperson AS SalespersonTbl
	INNER JOIN
	AdventureWorks2017.person.person AS personTbl
	ON
	SalesPersonTbl.BusinessEntityID = personTbl.BusinessEntityID
WHERE SalesPersonTbl.ModifiedDate > @current_load_time
	OR personTbl.ModifiedDate > @current_load_time
	AND NOT EXISTS ( SELECT * FROM AdvWorksDW.dbo.SalesPersonDim )
	
-- ProductDim

INSERT INTO AdvWorksDW.dbo.ProductDim( ProductID, ProductName )
	SELECT 
		ProductID,
		Name
	FROM
	AdventureWorks2017.production.product as ProductTbl
WHERE ProductTbl.ModifiedDate > @current_load_time
	AND NOT EXISTS ( SELECT * FROM AdvWorksDW.dbo.ProductDim )

-- TerritoryDim

INSERT INTO AdvWorksDW.dbo.TerritoryDim(TerritoryID, Name)
	SELECT
		TerritoryID,
		[group] + ' - ' + Name as GroupName
	FROM
	AdventureWorks2017.sales.salesTerritory AS TerritoryTbl
WHERE TerritoryTbl.ModifiedDate > @current_load_time
	AND NOT EXISTS ( SELECT * FROM AdvWorksDW.dbo.ProductDim )

-- DateDim

DECLARE @cnt int=0
DECLARE @start date 
DECLARE @NoOfDays int
DECLARE @date date

SELECT @start = max(dateID) FROM AdvWorksDW.DateDim
SELECT @NoOfDays = datediff(dd, @start, getdate())

SET DATEFIRST 1  --  Möndag som Week Start as 1

WHILE (@cnt < @NoOfDays) 
BEGIN
	SELECT @date = DATEADD(day, @cnt, @start)
    
	INSERT INTO AdvWorksDW.dbo.DateDim (
		DateID, 
		[Year] , 
		[Month], 
		Weekday, 
		WeekdayName , 
		Week, 
		[Day] , 
		Quarter, 
		QuarterName 
		)  
	VALUES (
		@date, 
		datepart(year, @date), 
		datepart(month, @date),  
		datepart(weekday, @date), 
		datename(weekday, @date), 
		datepart(week, @date),
		datepart(day, @date), 
		datepart(Q, @date),
		'Q' + cast(datename(Q, @date) as char(1))
		)
    SET @cnt +=1
END

--FYLLA NYA RÄDER I FACT TABEL

SELECT * INTO #Salesfact FROM AdvWorksDW.dbo.SalesFact WHERE 1 = 0

SET IDENTITY_INSERT #SalesFact ON

INSERT INTO #SalesFact(SalesPersonID, ProductID, TerritoryID, OrderDateID, Quantity, Sales, Profit, Loadtime)
SELECT
	SOH.SalesPersonID,
	SOD.ProductID,
	SOH.TerritoryID,
	CAST(SOH.OrderDate AS DATE) as 'OrderDateID',
	SOD.OrderQty,
	SOD.OrderQty * SOD.Unitprice as Sales,

	-- Ta sales minus Produktionens Kostnad *

	(SOD.OrderQty * SOD.Unitprice)
	 -
	(SOD.OrderQty *	(
					SELECT
					PCH.Standardcost
					FROM 
					AdventureWorks2017.Production.ProductCostHistory as PCH
					WHERE SOH.OrderDate BETWEEN StartDate AND ISNULL(EndDate,GETDATE())
					AND PCH.ProductID = SOD.ProductID
					)) AS Profit,
					
	@current_load_time
FROM
	AdventureWorks2017.sales.salesOrderHeader AS SOH
INNER JOIN 
	AdventureWorks2017.sales.salesOrderDetail AS SOD
ON SOH.salesOrderID = SOD.salesOrderID
WHERE SOH.ModifiedDate > @current_load_time OR SOD.ModifiedDate > @current_load_time


INSERT INTO AdvWorksDW.dbo.SalesFact (SalesPersonID, ProductID, TerritoryID, OrderDateID, Quantity, Sales, Profit, Loadtime)
SELECT (SalesPersonID, ProductID, TerritoryID, OrderDateID, Quantity, Sales, Profit, Loadtime)
FROM #SalesFact
WHERE SalesFactID = 0




