CREATE TABLE [dbo].[Member]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [NickName] NVARCHAR(30) NOT NULL UNIQUE, 
    [Username] NVARCHAR(30) NOT NULL UNIQUE, 
    [Password] VARCHAR(64) NOT NULL, 
    [Email] NVARCHAR(50) NOT NULL UNIQUE, 
    [RegisterDate] DATETIME NOT NULL
);

GO

CREATE TABLE [dbo].[Repo]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Name] NVARCHAR(50) NOT NULL UNIQUE, 
    [IsPrivate] BIT NOT NULL, 
    [MaxUsers] INT NOT NULL,
);

GO

CREATE TABLE [dbo].[Category]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [Name] NVARCHAR(50) NOT NULL, 
    [Descritpion] NVARCHAR(300) NOT NULL,

);

GO

CREATE TABLE [dbo].[ForumThread]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Title] NVARCHAR(50) NOT NULL, 
    [Content] NTEXT NOT NULL, 
    [CreationDate] DATETIME NOT NULL, 
    [EditDate] DATETIME NULL 
);

GO

CREATE TABLE [dbo].[Post]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Content] NTEXT NOT NULL, 
    [CreationDate] DATETIME NOT NULL, 
    [EditDate] DATETIME NULL
);
