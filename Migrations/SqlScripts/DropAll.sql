PRINT 'Dropping whole database'
GO

------------------------------------------
-- Drop constraints
------------------------------------------
DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FAST_FORWARD FOR
SELECT DISTINCT sql = 'ALTER TABLE ['+tc2.CONSTRAINT_SCHEMA+'].[' + tc2.TABLE_NAME + '] DROP [' + rc1.CONSTRAINT_NAME + ']'
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc1
LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 ON tc2.CONSTRAINT_NAME =rc1.CONSTRAINT_NAME

OPEN @Cursor FETCH NEXT FROM @Cursor INTO @Sql

WHILE (@@FETCH_STATUS = 0)
BEGIN
PRINT @Sql
Exec (@Sql)
FETCH NEXT FROM @Cursor INTO @Sql
END

CLOSE @Cursor DEALLOCATE @Cursor
GO


------------------------------------------
-- Drop views
------------------------------------------

DECLARE @sql VARCHAR(MAX) = ''
        , @crlf VARCHAR(2) = CHAR(13) + CHAR(10) ;

SELECT @sql = @sql + 'DROP VIEW ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(v.name) +';' + @crlf
FROM   sys.views v

PRINT @sql;
EXEC(@sql);
GO
------------------------------------------
-- Drop procs
------------------------------------------
PRINT 'Dropping all procs ...'
GO

DECLARE @sql VARCHAR(MAX) = ''
        , @crlf VARCHAR(2) = CHAR(13) + CHAR(10) ;

SELECT @sql = @sql + 'DROP PROC ' + QUOTENAME(SCHEMA_NAME(p.schema_id)) + '.' + QUOTENAME(p.name) +';' + @crlf
FROM   [sys].[procedures] p

PRINT @sql;
EXEC(@sql);
GO

------------------------------------------
-- Drop tables
------------------------------------------
PRINT 'Dropping all tables ...'
GO
EXEC sp_MSForEachTable 'DROP TABLE ?'
GO

------------------------------------------
-- Drop sequences
------------------------------------------

PRINT 'Dropping all sequences ...'
GO
DECLARE @DropSeqSql varchar(1024)
DECLARE DropSeqCursor CURSOR FOR
SELECT DISTINCT 'DROP SEQUENCE ' + s.SEQUENCE_SCHEMA + '.' + s.SEQUENCE_NAME
    FROM INFORMATION_SCHEMA.SEQUENCES s

OPEN DropSeqCursor

FETCH NEXT FROM DropSeqCursor INTO @DropSeqSql

WHILE ( @@FETCH_STATUS <> -1 )
BEGIN
    PRINT @DropSeqSql
    EXECUTE( @DropSeqSql )
    FETCH NEXT FROM DropSeqCursor INTO @DropSeqSql
END

CLOSE DropSeqCursor
DEALLOCATE DropSeqCursor
GO

------------------------------------------
-- Drop Schemas
------------------------------------------


DECLARE @schemas as varchar(1000) = 'StaticData,Ird,DataImport,Collateral,Report,Cds,CommonTrade,MarketData,TypeCode'
DECLARE @schemasXml as xml = cast(('<schema>'+replace(@schemas,',' ,'</schema><schema>')+'</schema>') as xml)

DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FAST_FORWARD FOR
SELECT sql = 'DROP SCHEMA ['+schemaName+']' FROM 
(SELECT CAST(T.schemaName.query('text()') as VARCHAR(200)) as schemaName FROM @schemasXml.nodes('/schema') T(schemaName)) as X
JOIN information_schema.schemata S on S.schema_name = X.schemaName

OPEN @Cursor FETCH NEXT FROM @Cursor INTO @Sql

WHILE (@@FETCH_STATUS = 0)
BEGIN
PRINT @Sql
Exec (@Sql)
FETCH NEXT FROM @Cursor INTO @Sql
END

CLOSE @Cursor DEALLOCATE @Cursor
GO