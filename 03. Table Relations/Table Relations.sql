--Problem 1:
CREATE DATABASE [OneToOneRelationship]

GO

USE [OneToOneRelationship]

GO

CREATE TABLE [Passports](
	[PassportID] INT PRIMARY KEY IDENTITY(101, 1),
	[PassportNumber] NCHAR(8) NOT NULL
)

GO

INSERT INTO [Passports]([PassportNumber])
	VALUES
	('N34FG21B'),
	('K65LO4R7'),
	('ZE657QP2')

GO

CREATE TABLE [Persons](
	[PersonID] INT PRIMARY KEY IDENTITY(1, 1),
	[FirstName] NVARCHAR(50) NOT NULL,
	[Salary] DECIMAL(8, 2) NOT NULL,
	[PassportID] INT FOREIGN KEY REFERENCES [Passports]([PassportID]) 
)

GO

ALTER TABLE [Persons]
ADD UNIQUE ([PassportID])

GO

INSERT INTO [Persons]([FirstName], [Salary], [PassportID])
	VALUES
	('Roberto',  43000.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

SELECT * FROM [Persons]

--Problem 2:
CREATE DATABASE [OneToManyRelationship]

GO

USE [OneToOneRelationship]

GO

CREATE TABLE [Manufacturers](
	[ManufacturerID] INT PRIMARY KEY IDENTITY(1, 1),
	[Name]	NVARCHAR(50) NOT NULL,
	[EstablishedOn] DATETIME2 NOT NULL
)

GO

INSERT INTO [Manufacturers]([Name], [EstablishedOn])
	VALUES
	('BMW', '1916-03-07'),
	('Tesla', '2003-01-01'),
	('Lada', '1966-05-01')

GO

CREATE TABLE [Models](
	[ModelsID] INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers]([ManufacturerID]) NOT NULL
)

INSERT INTO [Models]([Name], [ManufacturerID])
	VALUES
	('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3)

SELECT * FROM [Models]

--Problem 3:
CREATE DATABASE [ManyToManyRelationship]

GO

USE [ManyToManyRelationship]

GO

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL

)

CREATE TABLE [Exams](
	[ExamID] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

DROP TABLE [Exams]

CREATE TABLE [Exams](
	[ExamID] INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL
)

INSERT INTO [Students]([Name])
	VALUES
	('Mila'),
	('Toni'),
	('Ron')

INSERT INTO [Exams]([Name])
	VALUES
	('SpringMVC'),
	('Neo4j'),
	('Oracle11g')

CREATE TABLE [StudentsExams](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]) NOT NULL,
	[ExamID] INT FOREIGN KEY REFERENCES [Exams]([ExamID])
)

INSERT INTO [StudentsExams]([StudentID], [ExamID])
	VALUES
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)

SELECT * FROM [StudentsExams]

--Problem 4:
CREATE DATABASE [SelfReferencing]

GO

USE [SelfReferencing]

CREATE TABLE [Teachers](
	[TeacherID] INT PRIMARY KEY IDENTITY(101, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[ManagerID] INT FOREIGN KEY REFERENCES [Teachers]([TeacherID])
)

INSERT INTO [Teachers]([Name], [ManagerID])
	VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101)

SELECT * FROM [Teachers]


--Problem 5:
CREATE DATABASE [OnlineStore]

GO

USE [OnlineStore]

GO

CREATE TABLE [ItemTypes](
	[ItemTypeID] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL UNIQUE
)


GO

CREATE TABLE [Items](
	[ItemID] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes]([ItemTypeID]) NOT NULL
)

GO

CREATE TABLE [OrderItems](
	[OrderID] INT PRIMARY KEY IDENTITY(1, 1),
	[ItemID] INT FOREIGN KEY REFERENCES [Items]([ItemID])
)

GO

CREATE TABLE [Cities](
	[CityID] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL
)

GO

CREATE TABLE [Customers](
	[CustomerID] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[Birthday] DATETIME2 NULL,
	[CityID] INT FOREIGN KEY REFERENCES [Cities]([CityID])
)

GO

CREATE TABLE [Orders](
	[OrderID] INT PRIMARY KEY IDENTITY(101, 1),
	[CustomerID] INT FOREIGN KEY REFERENCES [Customers]([CustomerID]) NOT NULL
)

--Problem 6:
CREATE DATABASE [University]

GO

USE [University]

GO

CREATE TABLE [Majors](
	[MajorID] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Subjects](
	[SubjectID] INT PRIMARY KEY IDENTITY(1, 1),
	[SubjectName] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY IDENTITY(101, 1),
	[StudentNumber] NVARCHAR(20) NOT NULL,
	[StudentName] NVARCHAR(50) NOT NULL,
	[MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID])
)

CREATE TABLE [Agenda](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID])
)

CREATE TABLE [Payments](
	[PaymentID] INT PRIMARY KEY IDENTITY(1, 1),
	[PaymentDate] DATETIME2,
	[PayemntAmount] DECIMAL(6, 2),
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]) NOT NULL
)


--Problem 9:
USE [Geography]

SELECT [m].[MountainRange], [p].[PeakName], [p].[Elevation]
	 FROM [Mountains] AS [m]
LEFT JOIN [Peaks]     AS [p]
   	   ON [m].[Id] = [p].[MountainId]
	WHERE [m].[MountainRange] = 'Rila'
 ORDER BY [p].[Elevation] DESC
 