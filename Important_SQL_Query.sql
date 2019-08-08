SQL Important Queries

-----------------------------------------------------------------------------------------
/*Update Query */
/*
when we updating any table we need to 
start with "BEGIN TRANSCATION" or "BEGIN TRAN" and 
if confirm with count "COMMIT" else "ROLLBACK"
*/
--BEGIN TRANSACTION
BEGIN TRAN 
UPDATE table1
SET mobile_number = '0' + mobile_number
WHERE LEN(mobile_number) < '10'

-- check count how much record you need to update 
--if record that much record update you can COMMIT else ROLLBACK it will ROLLBACK 
-- COMMII: if we commit it will update and if we did not execute COMMIT or ROLLBACK it will block the table and front end query not work
-- ROLLBACK : If execute ROLLBACK it undo the update Which we just update but we have use COMMIT before ROLLBACK, then ROLLBACK will not work   	
COMMIT
ROLLBACK

-----------------------------------------------------------------------------------------

/*Get Database columns details*/
SELECT * FROM INFORMATION_SCHEMA.COLUMNS

/*Get table columns details*/
SELECT * FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='tablename'

-----------------------------------------------------------------------------------------

/*RENAME TABLE*/
sp_RENAME '[OldTableName]' , '[NewTableName]'

/*Renaming columns  name*/
sp_RENAME 'TableName.[OldColumnName]' , '[NewColumnName]', 'COLUMN'

-----------------------------------------------------------------------------------------

/*To Prevent deadlock in select query */
-- we need to use (nolock) after table name.it will prevent from deadlock
SELECT * FROM TABLE_NAME (nolock)
SELECT * FROM TABLE_NAME with (nolock) -- if we using sql server 2008 before version


-----------------------------------------------------------------------------------------

/*Create GUID in SQL SERVER*/

DECLARE @myid uniqueidentifier  
SET @myid = NEWID()  

-----------------------------------------------------------------------------------------

/*Insert Data one table to new table or for backup*/

SELECT * INTO newtable  FROM oldtable WHERE condition;

/* Inserting data  one table to other table  SELECT column */

insert into table2(mobile,name)
SELECT mobile,name from table1 where 

-----------------------------------------------------------------------------------------
/* Append Zero(0) in mobile number  if length is 9 digit */

BEGIN transaction 
UPDATE table1
SET mobile_number = '0' + mobile_number
WHERE LEN(mobile_number) < '10'

COMMIT
ROLLBACK

-----------------------------------------------------------------------------------------

/* Convert date format */
--URL : https://www.w3schools.com/sql/func_sqlserver_convert.asp

SELECT CONVERT(VARCHAR, 120) as 'current_date'
SELECT CONVERT(DATETIME, '2017-08-25') as current_date;
SELECT CONVERT(VARCHAR, '2017-08-25', 105); --25-08-2017

-- we can use different -2 code for format date 
 dd-mm-yyyy	-105


-----------------------------------------------------------------------------------------

/*Getting data between two dates */

select * from table1 where ( Date >= '2011-02-25' and Date <= '2011-02-27')
select * from table1 where ( Date BETWEEN '2011-02-25' AND '2011-02-27' ) 
 
-----------------------------------------------------------------------------------------
/*When we saving json in column. now we need to search any anthing from json or put in condtion*/

information_col  =  
[  
       { "id" : 2,"info": { "name": "John", "surname": "Smith","address": "this is address" }, "age": 25 },  
       { "id" : 5,"info": { "name": "Jane", "surname": "Smith","mobile":"897328947238" }, "dob": "2005-11-04T12:00:00" }  
 ]
 it is saved in information_col in people table.
--In the following example, the query uses both relational and JSON data (stored in a column named 'information_col' ) from a table:



SELECT Name,Surname,
 JSON_VALUE(information_col,'$.info.address') AS address,
FROM People
WHERE JSON_VALUE(information_col,'$.info.mobile')='897328947238'

-----------------------------------------------------------------------------------------

/*When we need to delete table */

drop table table_name
-----------------------------------------------------------------------------------------
/* delete from table */
BEGIN TRAN
delete from table_name where id='23134'

COMMIT
ROLLBACK

-----------------------------------------------------------------------------------------
/*Get all Store Procedure name */

select * from DatabaseName.information_schema.routines 
where routine_type = 'PROCEDURE'

-----------------------------------------------------------------------------------------
/*  List of tables with number of records   in database */

CREATE TABLE #Tab(  
Table_Name [varchar](max),  
Total_Records int );  
  
EXEC sp_MSForEachTable @command1=' Insert Into #Tab(Table_Name, Total_Records) SELECT ''?'', COUNT(*) FROM ?'  
SELECT * FROM #Tab t ORDER BY t.Total_Records DESC;  
DROP TABLE #Tab; 
-----------------------------------------------------------------------------------------
--Get SQL SERVER  version

SELECT @@VERSION AS Version_Name  
--Get SQL SERVER  Langauge
SELECT @@LANGUAGE AS Current_Language;  
-----------------------------------------------------------------------------------------
--List of Stored procedure created in last N days

SELECT name,sys.objects.create_date  
FROM sys.objects  
WHERE type='P'  
AND DATEDIFF(D,sys.objects.create_date,GETDATE())< 5  --(you change value as per your requirment in days)

--List of Stored procedure modified in last N days
SELECT name,modify_date  
FROM sys.objects  
WHERE type='P'  
AND DATEDIFF(D,modify_date,GETDATE())< N  

-----------------------------------------------------------------------------------------
/* Get all Nullable columns of a table */

SELECT OBJECT_NAME(c.OBJECT_ID) as Table_Name, c.name as Column_Name  
FROM sys.columns AS c  
JOIN sys.types AS t ON c.user_type_id=t.user_type_id  
WHERE c.is_nullable=0 AND OBJECT_NAME(c.OBJECT_ID)='Table_Name'  

-----------------------------------------------------------------------------------------
/* Get First Date of Current Month */
--Current month : July
SELECT CONVERT(VARCHAR(25),DATEADD(DAY,-(DAY(GETDATE()))+1,GETDATE()),105) First_Date_Current_Month;  
Result : 01-07-2019

/* Get last date of current month */
SELECT CONVERT(VARCHAR(25),DATEADD(DAY,-(DAY(GETDATE())), DATEADD(MONTH,1,GETDATE())),105) Last_Date_Current_Month;  \
Result : 31-07-2019

/*Get last date of previous month*/
SELECT CONVERT(VARCHAR(25),DATEADD(DAY,-(DAY(GETDATE())),GETDATE()),105) Last_Date_Previous_Month;  
Result : 30-06-2019

/* Get first date of next month */
SELECT CONVERT(VARCHAR(25),DATEADD(DAY,-(DAY(GETDATE())), DATEADD(MONTH,1,GETDATE())+1),105) First_Date_Next_Month;  
Result : 01-08-2019

-----------------------------------------------------------------------------------------

/* Swap the values of two columns*/

UPDATE Table_Name SET Column1=Column2, Column2=Column1  
-----------------------------------------------------------------------------------------

/* incrimental number in select Query */
                                         
SELECT ROW_NUMBER() OVER( ORDER BY SomeColumn ) AS 'rownumber',*
    FROM YourTable             
-----------------------------------------------------------------------------------------
/* If temp table exist drop it */
IF OBJECT_ID('tempdb..#Results') IS NOT NULL                                         
   DROP TABLE #Results
