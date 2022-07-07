USE [SoftUni]

GO

--Problem 1:
SELECT TOP (5) [e].[EmployeeID], [e].[JobTitle], [a].[AddressID], [a].[AddressText]
          FROM [Employees] AS [e]
     LEFT JOIN [Addresses] AS [a]
	        ON [e].[AddressID] = [a].[AddressID]
      ORDER BY [a].[AddressID]

--Problem 2:
SELECT TOP (50) [e].[FirstName], [e].[LastName], [t].[Name], [a].[AddressText]
	       FROM [Employees] AS [e]
	  LEFT JOIN [Addresses] AS [a]
	         ON [e].[AddressID] = [a].[AddressID]
	  LEFT JOIN [Towns] AS [t]
	         ON [a].[TownID] = [t].[TownID]
	   ORDER BY [FirstName], [LastName]

	--Problem 3:
	   SELECT [e].[EmployeeID], [e].[FirstName], [e].[LastName], [d].[Name] AS [DepartmentName]
		 FROM [Employees] AS [e]
	LEFT JOIN [Departments] AS [d]
		   ON [e].[DepartmentID] = [d].[DepartmentID]
		WHERE [d].[Name] = 'Sales'
	 ORDER BY [e].[EmployeeID] ASC 

 --Problem 4:
SELECT TOP (5) [e].[EmployeeID], [e].[FirstName], [e].[Salary], [d].[Name] AS [DepartmentName]
          FROM [Employees] AS [e]
     LEFT JOIN [Departments] AS [d]
	        ON [e].[DepartmentID] = [d].[DepartmentID]
         WHERE [e].[Salary] > 15000
      ORDER BY [d].[DepartmentID] ASC

--Problem 5:
SELECT TOP (3) [e].[EmployeeID], [e].[FirstName]
	      FROM [Employees] AS [e]
     LEFT JOIN [EmployeesProjects] AS [ep]
	        ON [e].[EmployeeID] = [ep].[EmployeeID]
	 LEFT JOIN [Projects] AS [p]
		    ON [ep].[ProjectID] = [p].[ProjectID]
	   	 WHERE [p].[Name] IS NULL
      ORDER BY [e].[EmployeeID] ASC

--Problem 6:
   SELECT [e].[FirstName], [e].[LastName], [e].[HireDate], [d].[Name] AS [DeptName]
     FROM [Employees] AS [e]
LEFT JOIN [Departments] AS [d]
	   ON [e].[DepartmentID] = [d].[DepartmentID]
	WHERE [e].[HireDate] >= '1999-01-01 00:00:00' AND [d].[Name] IN ('Sales', 'Finance')
 ORDER BY [e].[HireDate] ASC

--Problem 7:
SELECT TOP (5) [e].[EmployeeID], [e].[FirstName], [p].[Name]
          FROM [Employees] AS [e]
    INNER JOIN [EmployeesProjects] AS [ep]
            ON [e].[EmployeeID] = [ep].[EmployeeID]
     LEFT JOIN [Projects] AS [p]
            ON [ep].[ProjectID] = [p].[ProjectID]
	     WHERE [p].[StartDate] > '2002.08.13 00:00:00' AND [p].[EndDate] IS NULL
	  ORDER BY [e].[EmployeeID] ASC

--Problem 8:
    SELECT [e].[EmployeeID], [e].[FirstName],
	  CASE
	  WHEN [p].[StartDate] >= '2005.01.01 00:00:00' THEN NULL
	  ELSE [p].[Name] END AS [ProjectName]
      FROM [Employees] AS [e]
INNER JOIN [EmployeesProjects] AS [ep]
        ON [e].[EmployeeID] = [ep].[EmployeeID]
 LEFT JOIN [Projects] AS [p]
        ON [ep].[ProjectID] = [p].[ProjectID]
	 WHERE [e].[EmployeeID] = 24

--Problem 9:
    SELECT [e1].[EmployeeID], [e1].[FirstName], [e1].[ManagerID], [e2].[FirstName] AS [ManagerName]
      FROM [Employees] AS [e1]
INNER JOIN [Employees] AS [e2]
        ON [e1].[ManagerID] = [e2].[EmployeeID]
     WHERE [e1].[ManagerID] IN (3, 7)
  ORDER BY [e1].[EmployeeID] ASC

--Problem 10:
SELECT TOP (50) [e].[EmployeeID], CONCAT_WS(' ', [e].[FirstName], [e].[LastName]) AS [EmployeeName], 
								  CONCAT_WS(' ', [m].[FirstName], [m].[LastName]) AS [ManagerName],
								  [d].[Name] AS [DepartmentName]
	       FROM [Employees] AS [e]
     INNER JOIN [Employees] AS [m]
      	     ON [e].[ManagerID] = [m].[EmployeeID]
	  LEFT JOIN [Departments] AS [d]
			 ON [e].[DepartmentID] = [d].[DepartmentID]
	   ORDER BY [e].[EmployeeID]

--Problem 11:
SELECT MIN(avgsbd.AverageSalary) AS [MinAverageSalary]
FROM (
	SELECT AVG(e.Salary) AS [AverageSalary]
	FROM Employees AS e
	GROUP BY e.DepartmentID) AS [avgsbd]

--Problem 12:
GO

USE [Geography]

GO

   SELECT [c].[CountryCode], [m].[MountainRange], [p].[PeakName], [p].[Elevation]
     FROM [Countries] AS [c]
LEFT JOIN [MountainsCountries] AS [mc]
       ON [c].[CountryCode] = [mc].[CountryCode]
LEFT JOIN [Mountains] AS [m]
       ON [mc].[MountainId] = [m].[Id]
LEFT JOIN [Peaks] AS [p]
       ON [m].[Id] = [p].[MountainId]
    WHERE [c].[CountryCode] = 'BG' AND [p].[Elevation] > 2835
 ORDER BY [p].[Elevation] DESC


--Problem 13:
   SELECT [c].[CountryCode], COUNT([mc].[MountainId]) AS [MountainRanges]
     FROM [Countries] AS [c]
LEFT JOIN [MountainsCountries] AS [mc]
       ON [c].[CountryCode] = [mc].[CountryCode]
	WHERE [c].[CountryCode] IN ('BG', 'RU', 'US')
 GROUP BY [c].[CountryCode]

--Problem 14:
SELECT TOP (5) [c].[CountryName], [r].[RiverName]
          FROM [Countries] AS [c]
     LEFT JOIN [CountriesRivers] AS [cr]
            ON [c].[CountryCode]  = [cr].[CountryCode]
     LEFT JOIN [Rivers] AS [r]
            ON [cr].[RiverId] = [r].[Id]
	     WHERE [c].[ContinentCode] = 'AF'
	  ORDER BY [c].[CountryName] ASC

--Problem 15:
SELECT ranked.ContinentCode, ranked.CurrencyCode, ranked.CurrencyUsage
FROM (SELECT cc.ContinentCode, 
	   cc.CurrencyCode, 
	   cc.CurrencyUsage,
	   DENSE_RANK() OVER(PARTITION BY cc.ContinentCode ORDER BY cc.CurrencyUsage DESC) AS RankUsage
 FROM (
		  SELECT coun.ContinentCode, 
				 coun.CurrencyCode, 
				 COUNT(coun.CurrencyCode) AS CurrencyUsage
			FROM Countries AS coun
		   WHERE coun.CurrencyCode IS NOT NULL
		GROUP BY coun.ContinentCode, coun.CurrencyCode
		  HAVING COUNT(coun.CurrencyCode) > 1
	  ) AS cc
	) AS ranked
WHERE ranked.RankUsage = 1
ORDER BY ranked.ContinentCode ASC