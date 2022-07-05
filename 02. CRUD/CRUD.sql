--Problem 2:
SELECT * FROM [Departments]

--Problem 3:
SELECT [Name] FROM [Departments]

--Problem 4:
SELECT [FirstName], [LastName], [Salary] FROM [Employees]

--Problem 5:
SELECT [FirstName], [MiddleName], [LastName] FROM [Employees]

--Problem 6:
SELECT [FirstName] + '.' + [LastName] + '@' + 'softuni.bg'
	AS [Full Email Adress]
	FROM [Employees]

SELECT CONCAT([FirstName], '.', [LastName], '@', 'softuni.bg')
	AS [Full Email Adress]
	FROM [Employees]

SELECT CONCAT_WS('!', [FirstName], '.', [LastName], '@', 'softuni.bg')
	AS [Full Email Adress]
	FROM [Employees]

--Problem 7:
SELECT DISTINCT [Salary]
	AS [Salary]
	FROM [Employees]

--Problem 8:
SELECT * 
	FROM [Employees]
	WHERE [JobTitle] = 'Sales Representative'

--Problem 9:
SELECT [FirstName], [LastName], [JobTitle] 
  FROM [Employees]
  WHERE [Salary] > 20000 AND [Salary] < 30000
--WHERE [Salary] BETWEEN 20000 AND 30000

--Problem 10:
SELECT CONCAT_WS(' ', [FirstName], [MiddleName], [LastName])
    AS [Full Name]
	FROM [Employees]
	WHERE [Salary] = 25000 OR [Salary] = 14000 OR [Salary] = 12500 OR [Salary] = 23600
  --WHERE [Salary] IN (25000, 14000, 12500, 23600)

--Problem 11:
SELECT [FirstName], [LastName]
 FROM [Employees]
WHERE [ManagerID] IS NULL 

--Problem 12:
SELECT [FirstName], [LastName], [Salary]
  FROM [Employees]
 WHERE [Salary] > 50000
 ORDER BY [Salary] DESC

 --Problem 13:
SELECT TOP(5) [FirstName], [LastName]
         FROM [Employees]
     ORDER BY [Salary] DESC

--Problem 14:
SELECT [FirstName], [LastName]
  FROM [Employees]
 WHERE [DepartmentID] != 4

--Problem 15:
SELECT * FROM [Employees]
	 ORDER BY [Salary] DESC, [FirstName] ASC, [LastName] DESC, [MiddleName] ASC

--Problem 16:
SELECT [FirstName], [LastName], [Salary]
  FROM [Employees]

--Problem 17:
SELECT CONCAT_WS(' ', [FirstName], [MiddleName], [LastName])
	AS [Full Name], [JobTitle]
	FROM [Employees]

--Problem 18:
SELECT DISTINCT [JobTitle]
		   FROM [Employees]

--Problem 19:
SELECT TOP(10) * 
	FROM [Projects]
ORDER BY [StartDate] 

--Problem 20:
SELECT TOP(7) [FirstName], [LastName], [HireDate]
	     FROM [Employees]
	 ORDER BY [HireDate] DESC

--Problem 21:
SELECT * FROM [Departments]

UPDATE [Employees]
SET [Salary] += [Salary] * 0.12
WHERE [Salary] IN (4, 12, 42, 46)

SELECT [Salary] FROM [Employees]

--Problem 22:
USE [Geography]
SELECT [PeakName] FROM [Peaks]
ORDER BY [PeakName] ASC

--Problem 23:
SELECT [ContinentCode], [ContinentName] FROM [Continents]

SELECT TOP(30) [CountryName], [Population]
FROM [Countries]
WHERE [ContinentCode] = 'EU'
ORDER BY [Population] DESC, [CountryName]

--Problem 24:
SELECT [CurrencyCode], [Description] FROM [Currencies]

SELECT [CountryName], [CountryCode], 
	CASE
		WHEN [CurrencyCode] = 'EUR' THEN 'Euro'
		ELSE 'Not Euro'
		END AS [Currency]
FROM [Countries]
ORDER BY [CountryName]