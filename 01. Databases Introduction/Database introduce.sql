--Problem 1 to 6:
CREATE DATABASE [Minions]

USE [Minions]

CREATE TABLE [Minions] (
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	[AGE] INT NOT NULL
)

CREATE TABLE [Towns] (
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(100) NOT NULL
)

ALTER TABLE [Minions] 
ADD [TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL

INSERT INTO [Towns]([Id], [Name])
		VALUES
		(1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')

SELECT * FROM [Towns]

ALTER TABLE [Minions]
Alter Column [Age] INT  

INSERT INTO [Minions]([Id], [Name], [Age], [TownId])
		VALUES
		(1, 'Kevin', 22, 1),
		(3, 'Bob', 15, 3),
		(2, 'Steward', NULL, 2)

SELECT * FROM [Minions]
SELECT * FROM [Towns]

SELECT [NAME], [Age] FROM [Minions]

TRUNCATE TABLE [Minions]


--Problem 7:
CREATE TABLE [People] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY(MAX),
	CHECK (DATALENGTH([Picture]) <= 2000000),
	[Height] DECIMAL(3, 2),
	[Weight] DECIMAL(5, 2),
	[Gender]  CHAR(1) NOT NULL,
	CHECK ([Gender] = 'm' OR [Gender] ='f'),
	[Birthdate] DATE NOT NULL,
	[Biography] NVARCHAR(MAX)
)

INSERT INTO [People]([Name], [Height], [Weight], [Gender], [Birthdate])
	VALUES 
	('Rado', 1.75, 68.5, 'm', '2005-12-13'),
	('Pesho', NULL, NULL, 'm', '2000-03-25'),
	('Mariya', 1.65, 50, 'f', '2003-11-11'),
	('Viki', 1.60, 45.5, 'f', '1999-10-22'),
	('Peter', 1.80, 77.7, 'm', '1990-8-7')

ALTER TABLE [People] 
ADD CONSTRAINT DE_Biography DEFAULT ('No biography provided...') FOR [Biography]

SELECT * FROM [People]

--Problem 8:
CREATE TABLE [Users](
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY,
	CHECK (DATALENGTH([ProfilePicture]) <= 900),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT,
	CHECK ([IsDeleted] = 0 OR [IsDeleted] = 1)
)


INSERT INTO [Users]([Username], [Password], [ProfilePicture], [LastLoginTime], [IsDeleted])
	VALUES
		('calisthenicsGuy', '12345', NULL, NULL, 0),
		('mitni4arya', '54321', NULL, NULL, 1),
		('calisthenicsGuy2', '678910', NULL, NULL, 0),
		('mitni4arya2', '109876', NULL, NULL, 1),
		('calisthenicsGuy3', '1112131415', NULL, NULL, 0)

--This query will not complete, because the type of [ProfilePicture] is VARBINARY 
--ALTER TABLE [Users]
--ADD CONSTRAINT DE_ProfilePicture DEFAULT ('No profile picture provided...') FOR [ProfilePicture]

SELECT * FROM [Users]

--Problem 9:
ALTER TABLE [Users]
	ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username)

--Problem 10:
ALTER TABLE [Users]
	ADD CONSTRAINT CHK_PasswordLength CHECK(DATALENGTH([Password]) >= 5)

--Problem 11:
ALTER TABLE [Users]
	ADD CONSTRAINT DE_DefaultLastLoginTimeValue DEFAULT('current time') FOR [LastLoginTime]



--Problem 13:
CREATE DATABASE [MOVIES]

USE [Movies]

CREATE TABLE [Directors](
	[Id] INT PRIMARY KEY IDENTITY,
	[DirectorName] NVARCHAR(50),
	[NOTES] NVARCHAR(MAX)
)

ALTER TABLE [Directors]
ALTER COLUMN [DirectorName] NVARCHAR(50) NOT NULL

CREATE TABLE [Genres](
	[Id] INT PRIMARY KEY IDENTITY,
	[GenreName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

GO

CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE [Movies](
	[Id] INT PRIMARY KEY IDENTITY,
	[Title] NVARCHAR(50),
	[DirctorId] INT,
	[CopyrigthYear] NVARCHAR(100),
	[Length] INT,
	[GenrelId] INT,
	[CategoryId] INT,
	[Rating] TINYINT,
	[Notes] NVARCHAR(MAX)
)

ALTER TABLE [Movies]
ADD [DirectorId] INT FOREIGN KEY REFERENCES [Directors]([Id]) NOT NULL 


ALTER TABLE [Movies]
DROP COLUMN [GenrelId]

ALTER TABLE [Movies]
ADD [GenrelId] INT FOREIGN KEY REFERENCES [Genres]([Id]) NOT NULL

ALTER TABLE [Movies]
DROP COLUMN [CategoryId]

ALTER TABLE [Movies]
ADD [CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id])


--Problem 14:
CREATE DATABASE [CarRental]

USE [CarRental]

CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(30) NOT NULL,
	[DailyRate] NVARCHAR(MAX),
	[WeeklyRate] NVARCHAR(MAX),
	[MonthlyRate] NVARCHAR(MAX),
	[WeekendRate] NVARCHAR(MAX)
)

GO

CREATE TABLE [Cars](
	[Id] INT PRIMARY KEY IDENTITY,
	[PlateNumbar] NVARCHAR(20) NOT NULL,
	[Manifacturer] NVARCHAR(50),
	[Model] NVARCHAR(20) NOT NULL,
	[CarYear] DATETIME2 NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
	[Doors] TINYINT,
	[Picture] VARBINARY(max),
	CHECK (DATALENGTH([Picture]) <= 200000),
	[Condition] NVARCHAR(20),
	[Available] BIT NOT NULL,
	CHECK ([Available] = 0 OR [Available] = 1)
)

CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(100) NOT NULL,
	[LastName] NVARCHAR(100) NOT NULL,
	[Title] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(MAX)	
)

CREATE TABLE [Customers](
	[Id] INT PRIMARY KEY IDENTITY,
	[DriverLicenceNumber] NVARCHAR(100) NOT NULL,
	[FullName] NVARCHAR(150) NOT NULL,
	[Adress] NVARCHAR(150),
	[City] NVARCHAR(200),
	[ZIPCode] INT,
	[Notes] NVARCHAR(MAX),
)

CREATE TABLE RentalOrders(
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]) NOT NULL,
	[CustomerId] INT FOREIGN KEY REFERENCES [Customers]([Id]) NOT NULL,
	[CarId] INT FOREIGN KEY REFERENCES [Cars]([Id]) NOT NULL,
	[TankLevel]	INT,
	[KilometrageStart] INT,
	[KilometrageEnd] INT,
	[TotalKilometrage] BIGINT,
	[StartDate] DATETIME2 NOT NULL,
	[EndDate] DATETIME2,
	[TotalDays] INT,
	[RateApplied] INT,
	[TaxRate] DECIMAL(38, 2),
	[OrderStatus] BIT,
	CHECK ([OrderStatus] = 1 OR [OrderStatus] = 0),
	[Notes] NVARCHAR(max)
)

SELECT * FROM [RentalOrders]

--Problem 16:
CREATE DATABASE [SoftUni]

USE [SoftUni]

CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL
)

GO

CREATE TABLE [Adresses](
	[Id] INT PRIMARY KEY IDENTITY,
	[AdressText] NVARCHAR(MAX) NOT NULL,
	[TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL
)

GO

CREATE TABLE [Departments](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL
)

GO

CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(30) NOT NULL,
	[MiddleName] NVARCHAR(30) NOT NULL,
	[LastName] NVARCHAR(30) NOT NULL,
	[JobTitle] NVARCHAR(30) NOT NULL,
	[DepartmentId] INT FOREIGN KEY REFERENCES [Departments]([Id]) NOT NULL,
	[HireDate] DATETIME2 NOT NULL,
	[Salary] DECIMAL(8, 2),
	[AdressId] INT FOREIGN KEY REFERENCES [Adresses]([Id]) NOT NULL
)

--Problem 17 Back up database
BACKUP DATABASE SoftUni
TO DISK = 'D:\softuni-backup.bak'

DROP DATABASE SoftUni

RESTORE DATABASE SoftUni
FROM DISK = 'D:\softuni-backup.bak'

USE SoftUni

--Problem 18
INSERT INTO [Towns]([Name])
	VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

SELECT * FROM [Towns]

GO

INSERT INTO [Departments]([Name])
	VALUES
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

SELECT * FROM [Departments]

INSERT INTO [Adresses]([AdressText], [TownId])
	VALUES
	('UL. T. Kableshkov', 1),
	('UL. I. Alexandrov', 3)

--ALTER TABLE [Employees]
--ALTER COLUMN [AdressId] INT FOREIGN KEY REFERENCES [Adresses]([Id])

INSERT INTO [Employees]([FirstName], [MiddleName], [LastName], [JobTitle], [DepartmentId], [HireDate], [Salary], [AdressId])
	VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, 2),
	('Peter', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, 1)
	/*('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2004-03-01', 3500.00),
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00)*/

--Problem 19
SELECT * FROM [Towns]
SELECT * FROM [Departments]
SELECT * FROM [Employees]

--Problem 20
SELECT * FROM [Towns]
ORDER BY [Name]

SELECT * FROM [Departments]
ORDER BY [NAME]

SELECT * FROM [Employees]
ORDER BY [Salary]

--Problem 21
SELECT [Name] FROM Towns
ORDER BY [Name]

SELECT [Name] FROM Departments
ORDER BY [Name]

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC