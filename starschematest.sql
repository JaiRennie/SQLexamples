--CREATE DATABASE AND TABLES--

/*
CREATE DATABASE WWItransactions
*/
/*
CREATE TABLE InvoiceFact (
InvoiceCount int identity(1,1) primary key,
CustomerID int,
InvoiceDate date,
ProductID int,
Quantity int,
Sales float,
Profit float
)
*/

/*
CREATE TABLE CustomerDim (
CustomerID int primary key,
CustomerName nvarchar(100)
)
*/

/*
CREATE TABLE ProductDim (
ProductID int primary key,
ProductName nvarchar(100),
)
*/

/*
CREATE TABLE DateDim(
[Date] date primary key,
Year int,
Month int,
MonthName varchar(20),
Weekday int,
WeekdayName varchar(20),
Week int,
Day int,
Quarter int, 
QuarterName varchar(20)
)
*/

--INSERT DATA INTO TABLES--
--INVOICE FACT TABLE--

/*
INSERT INTO InvoiceFact (CustomerID, InvoiceDate, ProductID, Quantity, Sales, Profit)
SELECT   
	CustomerID as CustomerID, 
	invoiceDate,  
	StockItemID as ProductID, 
	Quantity, 
	Quantity * UnitPrice as Sales,
	LineProfit as Profit
FROM
WideWorldImporters.sales.Invoices AS Inv
inner join WideWorldImporters.sales.InvoiceLines AS InvLn
on Inv.InvoiceID = invln.invoiceID;
*/

--CUSTOMER DIMENSION TABLE--
/*
INSERT INTO CustomerDim (CustomerID, CustomerName)
SELECT 
CustomerID,
CustomerName
FROM
WideWorldImporters.sales.Customers;
*/

--PRODUCT DIMENSION TABLE--
/*
INSERT INTO ProductDim (ProductID, ProductName)
SELECT
StockItemID,
StockItemName
FROM
WideWorldImporters.Warehouse.StockItems;
*/

--DATE DIMENSION TABLE--
--INSERTS FULL LIST OF DATES INTO TABLE FOR ANALYSIS STEP--
/*
DECLARE @cnt int=0
DECLARE @start date 
DECLARE @NoOfDays int
DECLARE @date date

SELECT @start = min(InvoiceDate) FROM WideWorldImporters.sales.Invoices
SELECT @NoOfDays = datediff(dd, @start, getdate())

SET DATEFIRST 1  -- Sets Monday as Week Start as 1

WHILE (@cnt < @NoOfDays) 
BEGIN
	SELECT @date = DATEADD(day, @cnt, @start)
    
	INSERT INTO [DateDim] (
		[Date], 
		Year , 
		Month, 
		MonthName ,
		Weekday, 
		WeekdayName , 
		Week, 
		Day , 
		Quarter, 
		QuarterName 
		)  
	VALUES (
		@date, 
		datepart(year, @date), 
		datepart(month, @date), 
		datename(month, @date), 
		datepart(weekday, @date), 
		datename(weekday, @date), 
		datepart(week, @date),
		datepart(day, @date), 
		datepart(Q, @date),
		'Q' + cast(datename(Q, @date) as char(1))
		)

    SET @cnt +=1
END
*/

--END INSERT STEP--

--CONTROL STEP--
/*
SELECT top 100 * FROM InvoiceFact
SELECT top 100 * FROM DateDim
SELECT top 100 * FROM ProductDim
SELECT top 100 * FROM CustomerDim
*/

--USE DATABASE DIAGRAM TO CREATE RELATIONSHIPS--