--Problem 1:
CREATE DATABASE [OneToOneRelation]
USE [OneToOneRelation]

GO

CREATE TABLE [Passports](
	[PassportId] INT PRIMARY KEY NOT NULL,
	[PassportNumber] NCHAR(8) NOT NULL,
)

GO

CREATE TABLE [Persons](
	[PersonId] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(100) NOT NULL,
	[Salary] DECIMAL(8, 2),
	[PassportId] INT FOREIGN KEY REFERENCES [Passports]([PassportId])
)

GO

INSERT INTO [Passports]([PassportId], [PassportNumber])
	VALUES
	(101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2')
	
GO

INSERT INTO [Persons]([FirstName], [Salary], [PassportId])
	VALUES
	('Roberto', 43300.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

Select * from [Persons]