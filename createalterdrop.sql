/*create table settings
(
parameter varchar(100)
)

insert into setting values('truecolor')

delete top(9) from settings

set rowcount 3 --will be removedin future version of SQL
delete from settings

delete from settings
where id <> 0	--or >1

declare @cnt int
select @cnt = count(*) from settings
select @cnt = @count /3
Delete top(@cnt) from settings

--delete top(30) percent from settings
*/


sp_help employee

create database
create table 
alter database
alter table
drop database
drop table

--create database
create database personal

--create table
create table table_name (
column name datatype Rules,  --rulesexmp.  NOTNULL, PRIMARYKEY, 
column name datatype,
CHECK						 --set rules on the data inserted into table 
CONSTRAINT 
)


--1
SELECT * INTO ANST FROM employee
--2
alter table ANST
alter column lastname varchar(50)
--3
alter table ANST
ADD Manager char(1)
--4
INSERT ANST (Manager)
VALUES 'Y'
WHERE ManagerID = (
	SELECT ManagerID FROM Employee
	GROUP BY ManagerId
	HAVING count(ManagerId) > 1) 