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


--Problem 7 to :
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
ADD CONSTRAINT DE_Biograph DEFAULT ('No biography provided...') FOR [Biography]

SELECT * FROM [People]