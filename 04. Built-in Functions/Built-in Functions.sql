USE [SoftUni]

GO

--Problem 1:
SELECT [FirstName], [LastName]
  FROM [Employees]
 WHERE [FirstName] LIKE 'Sa%'

 --Problem 2:
 SELECT [FirstName], [LastName]
   FROM [Employees]
  WHERE [LastName] LIKE '%ei%'

  --Problem 3:
  SELECT [FirstName]
    FROM [Employees]
 --WHERE [DepartmentID] IN (3, 10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005
   WHERE [DepartmentID] IN (3, 10) AND DATEPART(YEAR, [HireDate]) BETWEEN 1995 AND 2005 

  --Problem 4:
  SELECT [FirstName], [LastName]
    FROM [Employees]
   WHERE [JobTitle] NOT LIKE '%engineer%'

--Problem 5:
          SELECT [Name]
            FROM [Towns]
WHERE DATALENGTH([Name]) IN (5, 6)
        ORDER BY [Name] ASC

--Problem 6:
  SELECT [TownID], [Name]
    FROM [Towns]
 --WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
   WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name] ASC

--Problem 7:
  SELECT [TownID], [Name]
    FROM [Towns]
   WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name] ASC

--Problem 8:
CREATE VIEW [V-EmployeesHiredAfter2000] AS
SELECT [FirstName], [LastName]
  FROM [Employees]
 WHERE DATEPART(YEAR, [HireDate]) > 2000

--Problem 9:
 SELECT [FirstName], [LastName]
   FROM [Employees]
  WHERE DATALENGTH([LastName]) = 5

--Problem 10:
    SELECT [EmployeeID], [FirstName], [LastName], [Salary],
           DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID]) AS [Rank]
      FROM [Employees]
     WHERE [Salary] BETWEEN 10000 AND 50000 
  ORDER BY [Salary] DESC
  
--Problem 11:
SELECT * 
    FROM 
	   (
		  SELECT [EmployeeID], [FirstName], [LastName], [Salary], 
	             DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID]) AS [Rank]
            FROM [Employees]
           WHERE [Salary] BETWEEN 10000 AND 50000
      )
	  AS [TempQuery]
   WHERE [Rank] = 2
ORDER BY [Salary] DESC

--Problem 12:
USE [Geography]

GO

  SELECT [CountryName], [IsoCode]
    FROM [Countries]
   WHERE [CountryName] LIKE '%A%A%A%'
ORDER BY [IsoCode] ASC

--Problem 13:
   SELECT [p].[PeakName], [r].[RiverName], LOWER(CONCAT_WS('', LEFT([p].[PeakName], LEN([p].[PeakName]) - 1), [r].[RiverName])) AS [Mix]
     FROM [Peaks] AS [p],
          [Rivers] AS [r]
    WHERE RIGHT([p].[PeakName], 1) = LEFT([r].[RiverName], 1)
 ORDER BY [Mix]

 --Problem 14:
 GO
 USE [Diablo]
 GO

  SELECT [Name], [Start]
    FROM [Games]
   WHERE [Start] BETWEEN '2011-01-01 00:00:00' AND '2012-01-01 00:00:00'
ORDER BY [Start], [Name]

--Problem 15:
  SELECT [u].[Username], SUBSTRING([u].[Email], CHARINDEX('@', [u].[Email]) + 1, LEN([u].Email)) 
	  AS [Email Provider]
    FROM [Users] AS [u]
ORDER BY [Email Provider] ASC, [u].[Username] ASC

--Problem 16:
SELECT [Username], [IpAddress] 
  FROM [Users]
 WHERE [IpAddress] LIKE '___.1_%._%.___'
 ORDER BY [Username] ASC