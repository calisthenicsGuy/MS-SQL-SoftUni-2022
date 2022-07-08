USE [SoftUni]


--Problem 1:
GO

CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT [FirstName], [LastName]
	  FROM [Employees]
	 WHERE [Salary] > 35000
END

GO

EXEC [dbo].[usp_GetEmployeesSalaryAbove35000]


--Problem 2:
GO
CREATE PROCEDURE [usp_GetEmployeesSalaryAboveNumber] (@minSalary DECIMAL(18, 4))
AS
BEGIN
	SELECT [FirstName], [LastName]
	  FROM [Employees]
	 WHERE [Salary] >= @minSalary
END
GO


EXEC [dbo].[usp_GetEmployeesSalaryAboveNumber] 48100
EXEC [dbo].[usp_GetEmployeesSalaryAboveNumber] 35000

--Problem 3:
GO
CREATE PROCEDURE [usp_GetTownsStartingWith] @firstLetterOfTown NCHAR(1)
AS
BEGIN
	SELECT [Name] 
	    AS [Town]
	  FROM [Towns]
	 WHERE LEFT([Name], 1) = LOWER(@firstLetterOfTown)
END
GO

EXEC [usp_GetTownsStartingWith] 'b'
EXEC [usp_GetTownsStartingWith] 's'

--Problem 4:
GO
CREATE PROCEDURE [usp_GetEmployeesFromTown] @townName NVARCHAR(100)
AS
BEGIN
	   SELECT [FirstName], [LastName]
		 FROM [Employees] AS [e]
	LEFT JOIN [Addresses] AS [a]
		   ON [e].[AddressID] = [a].[AddressID]
	LEFT JOIN [Towns] AS [t]
		   ON [a].[TownID] = [t].[TownID]
		WHERE [t].[Name] = @townName
END
GO

--Problem 5:
GO
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(8)
AS
BEGIN
    DECLARE @salaryLevel NVARCHAR(8)
	IF @salary < 30000
	BEGIN
		SET @salaryLevel = 'Low'
	END
	IF @salary BETWEEN 30000 AND 50000
	BEGIN
		SET @salaryLevel = 'Average'
	END
	IF @salary > 50000
	BEGIN
		SET @salaryLevel = 'High'
	END

	RETURN @salaryLevel
END
GO

SELECT [Salary], 
       [dbo].[ufn_GetSalaryLevel]([Salary]) AS [SalaryLevel]
  FROM [Employees]

--Problem 6:
GO
CREATE PROCEDURE [usp_EmployeesBySalaryLevel] @levelOfSalary NVARCHAR(8)
AS
BEGIN
	SELECT [FirstName], [LastName]
	  FROM [Employees]
	 WHERE [dbo].[ufn_GetSalaryLevel]([Salary]) = @levelOfSalary
END
GO

EXEC [dbo].[usp_EmployeesBySalaryLevel] 'low'
EXEC [dbo].[usp_EmployeesBySalaryLevel] 'high'

--Problem 7:
GO
CREATE FUNCTION ufn_IsWordComprised(@SetOfLetters NVARCHAR(50), @Word NVARCHAR(100)) 
RETURNS BIT AS
BEGIN

	DECLARE @Index INT= 1;	

	WHILE (@Index <= LEN(@Word))
		BEGIN
			--Check if the @setOfLetters contains the current letter 
			IF CHARINDEX(SUBSTRING(@Word, @Index, 1), @SetOfLetters) = 0 
			BEGIN
				RETURN 0
			END 
				SET @Index += 1;
		END

			RETURN 1
END
GO

--Problem 8:
GO
CREATE PROC usp_DeleteEmployeesFromDepartment (@DepartmentId INT) AS
DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (
		SELECT EmployeeID FROM Employees
		WHERE DepartmentID = @DepartmentId
						)

 UPDATE Employees
 SET ManagerID = NULL
 WHERE ManagerID IN (
		SELECT EmployeeID FROM Employees
		WHERE DepartmentID = @DepartmentId
		)

ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL

UPDATE Departments
	SET ManagerID = NULL 
	WHERE DepartmentID = @DepartmentId

DELETE FROM Employees
	WHERE DepartmentID = @DepartmentId

DELETE FROM Departments
	WHERE DepartmentID = @DepartmentId

SELECT COUNT(*) FROM Employees
	WHERE DepartmentID = @DepartmentId
GO

--Problem 9:
USE [Bank]

GO
CREATE PROCEDURE [usp_GetHoldersFullName]
AS
BEGIN
		SELECT CONCAT_WS(' ', [FirstName], [LastName]) 
		    AS [Full Name]
		  FROM [AccountHolders]
END
GO

--Problem 10:
GO
CREATE PROCEDURE [usp_GetHoldersWithBalanceHigherThan] @money MONEY
AS
BEGIN
	     SELECT [ah].[FirstName],
		        [ah].[LastName] 
	       FROM [AccountHolders] AS [ah]
	  LEFT JOIN [Accounts] AS [a]
	         ON [ah].[Id] = [a].[Id]
		  WHERE [a].[Balance] > @money
	   ORDER BY [ah].[FirstName],
		        [ah].[LastName] 
END
GO

--Problem 11:
GO
CREATE FUNCTION ufn_CalculateFutureValue (@Sum DECIMAL(20,2), @YearlyInterest FLOAT, @Years INT)
RETURNS DECIMAL(20,4) AS
BEGIN
	DECLARE @Result DECIMAL(20,4) = @Sum * POWER((1+@YearlyInterest), @Years)
	RETURN @Result
END
GO

--Problem 12:
GO
CREATE PROC usp_CalculateFutureValueForAccount(@accountId INT, @interestRate DECIMAL(15, 2))
AS
BEGIN
	SELECT TOP (1) ah.Id AS [Account Id],
		   ah.FirstName AS [First Name],
		   ah.LastName AS [Last Name],
		   a.Balance AS [Current Balance],
		   [dbo].ufn_CalculateFutureValue(a.Balance, @interestRate, 5) AS [Balance in 5 years]
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON a.AccountHolderId = ah.Id
	WHERE ah.Id = @accountId
END