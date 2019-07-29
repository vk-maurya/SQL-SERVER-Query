USE [DATABASENAME]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Store_prodcedure_name] @start_Date datetime,@end_date datetime
AS

-- when we need local variable we use DECLARE
DECLARE @find varchar(30);  
/* Also allowed:   
DECLARE @find varchar(30) = 'Man%';  
*/  
SET @find = 'Walt%';

SELECT  * FROM table_name where (start_date=@start_Date AND end_date=@end_date)  AND LastName LIKE @find;  


/*
We can call this SP by using this way
EXEC [Store_prodcedure_name]  @start_date='2019-06-30 18:30:00', @end_date='2019-07-31 18:30:00'
*/  
