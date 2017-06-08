DROP TABLE [dbo].[RepoMember];

GO 

ALTER TABLE [dbo].[Category] DROP CONSTRAINT [FK_RepoCategory];
ALTER TABLE [dbo].[Category] DROP COLUMN  [RepoId];

GO 

ALTER TABLE [dbo].[ForumThread] DROP CONSTRAINT [FK_CategoryForumThread];
ALTER TABLE [dbo].[ForumThread] DROP COLUMN  [CategoryId];

GO 

ALTER TABLE [dbo].[ForumThread] DROP CONSTRAINT [FK_MemberForumThread];
ALTER TABLE [dbo].[ForumThread] DROP COLUMN  [MemberId];

GO 

ALTER TABLE [dbo].[Post] DROP CONSTRAINT [FK_ForumThreadPost];
ALTER TABLE [dbo].[Post] DROP COLUMN  [ForumThreadId];

GO 

ALTER TABLE [dbo].[Post] DROP CONSTRAINT [FK_MemberPost];
ALTER TABLE [dbo].[Post] DROP COLUMN  [MemberId];
