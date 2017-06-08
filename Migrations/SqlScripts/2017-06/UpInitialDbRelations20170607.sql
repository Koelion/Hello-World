CREATE TABLE [dbo].[RepoMember]
(
	[RepoId] int REFERENCES [Repo]([Id]) NOT NULL,
    [ItemID] int REFERENCES [Member]([Id]) NOT NULL,
    PRIMARY KEY ([RepoId], [ItemID])
);

Go

ALTER TABLE [dbo].[Category] ADD [RepoId] int  NOT NULL;
GO 
ALTER TABLE [dbo].[Category] ADD CONSTRAINT [FK_RepoCategory]
FOREIGN KEY ([RepoId]) REFERENCES Repo([Id]);

Go

ALTER TABLE [dbo].[ForumThread] ADD [CategoryId] int  NOT NULL;
GO 
ALTER TABLE [dbo].[ForumThread] ADD CONSTRAINT [FK_CategoryForumThread]
FOREIGN KEY ([CategoryId]) REFERENCES [Category]([Id]);

Go

ALTER TABLE [dbo].[ForumThread] ADD [MemberId] int NOT NULL;
GO 
ALTER TABLE [dbo].[ForumThread] ADD CONSTRAINT [FK_MemberForumThread]
FOREIGN KEY ([MemberId]) REFERENCES [Member]([Id]);

Go

ALTER TABLE [dbo].[Post] ADD [ForumThreadId] int NOT NULL;
GO 
ALTER TABLE [dbo].[Post] ADD CONSTRAINT [FK_ForumThreadPost]
FOREIGN KEY ([ForumThreadId]) REFERENCES [ForumThread]([Id]);

Go

ALTER TABLE [dbo].[Post] ADD [MemberId] int NOT NULL;
GO 
ALTER TABLE [dbo].[Post] ADD CONSTRAINT [FK_MemberPost]
FOREIGN KEY ([MemberId]) REFERENCES [ForumThread]([Id]);

