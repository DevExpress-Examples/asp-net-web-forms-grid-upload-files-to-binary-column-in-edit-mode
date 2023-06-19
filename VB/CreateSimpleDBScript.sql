USE [master]
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'BinaryImagesDB')
DROP DATABASE [BinaryImagesDB]
GO

CREATE DATABASE [BinaryImagesDB]
GO

USE [BinaryImagesDB]
GO

CREATE TABLE [dbo].[BinaryImagesTable] (
	[ID] int IDENTITY(1,1) NOT NULL,
	[Picture] varbinary(max) NULL,
	CONSTRAINT [PK_BinaryImages] PRIMARY KEY CLUSTERED ([ID])
)

GO

INSERT INTO [BinaryImagesTable] VALUES (NULL)