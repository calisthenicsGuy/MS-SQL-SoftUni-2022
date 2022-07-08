USE [Gringotts]

GO

SELECT *
  FROM [WizzardDeposits]

--Problem 1:
SELECT COUNT([Id]) AS [Count]
  FROM [WizzardDeposits]
--SELECT COUNT(*) FROM [WizzardDeposits] AS [Count]
  
--Problem 2:
SELECT MAX([MagicWandSize]) AS [LongestMagicWand] 
	  FROM [WizzardDeposits]

--Problem 3:
  SELECT [DepositGroup], MAX([MagicWandSize]) AS [LongestMagicWand]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--Problem 4:
SELECT TOP (2) [DepositGroup]
          FROM [WizzardDeposits]
      GROUP BY [DepositGroup]
	  ORDER BY AVG([MagicWandSize])

--Problem 5:
  SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--Problem 6:
  SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
    FROM [WizzardDeposits]
   WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]

--Problem 7:
SELECT * 
  FROM 
     (
		   SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
			 FROM [WizzardDeposits]
			WHERE [MagicWandCreator] = 'Ollivander family'
		 GROUP BY [DepositGroup]
	 ) AS [GroupDepositSumQuery]
    WHERE [TotalSum] < 150000
 ORDER BY [TotalSum] DESC

 --Problem 8:
  SELECT [DepositGroup], [MagicWandCreator], MIN([DepositCharge]) AS [MinDepositCharge]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator] ASC, [DepositGroup] ASC

--Problem 9:
SELECT [AgeGroup],  COUNT(*) AS WizardCount
  FROM 
	 (
		 SELECT
		   CASE 
				WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
				WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
				WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
				WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
				WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
				WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
				WHEN [Age] > 61 THEN '[61+]'
		   END AS [AgeGroup]
			 FROM [WizzardDeposits]
	 ) AS [AgeGroupingQuery]
 GROUP BY [AgeGroup]

 --Problem 10:
SELECT [FirstLetter]
  FROM 
	 (
		SELECT DISTINCT LEFT([FirstName], 1) AS [FirstLetter]
		  FROM [WizzardDeposits]
		 WHERE [DepositGroup] = 'Troll Chest'
	 ) AS [UniqueFirstLetterQuery]
	 ORDER BY [FirstLetter] ASC
	
--Problem 11:
SELECT [DepositGroup], [IsDepositExpired], AVG([DepositInterest]) AS [AverageInterest]
  FROM [WizzardDeposits]
  WHERE [DepositExpirationDate] > '1985/01/01'
  GROUP BY [DepositGroup], [IsDepositExpired]
  ORDER BY [DepositGroup] DESC, [IsDepositExpired]

--Problem 12:
SELECT ABS(SUM(tt.DepositDifference)) AS SumDifference FROM 
	(SELECT wiz1.DepositAmount - wiz2.DepositAmount AS DepositDifference 
	 FROM WizzardDeposits AS wiz1
	 JOIN WizzardDeposits AS wiz2 ON wiz1.Id = (wiz2.Id + 1)) AS tt	 


