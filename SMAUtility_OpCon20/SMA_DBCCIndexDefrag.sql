/*
*/

USE  [$(DatabaseName)]
GO

-- Declare variables
SET NOCOUNT ON
DECLARE @tablename VARCHAR (128)
DECLARE @execstr   VARCHAR (255)
DECLARE @objectid  INT
DECLARE @indexid   INT
DECLARE @frag      DECIMAL
DECLARE @maxfrag   DECIMAL
DECLARE @fraglist  TABLE(
   ObjectName CHAR (255),
   ObjectId INT,
   IndexName CHAR (255),
   IndexId INT,
   Lvl INT,
   CountPages INT,
   CountRows INT,
   MinRecSize INT,
   MaxRecSize INT,
   AvgRecSize INT,
   ForRecCount INT,
   Extents INT,
   ExtentSwitches INT,
   AvgFreeBytes INT,
   AvgPageDensity INT,
   ScanDensity DECIMAL,
   BestCount INT,
   ActualCount INT,
   LogicalFrag DECIMAL,
   ExtentFrag DECIMAL)


-- Decide on the maximum fragmentation to allow
SELECT @maxfrag = 15.0

-- Declare cursor
DECLARE tables CURSOR FOR
   SELECT TABLE_NAME
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'

-- Open the cursor
OPEN tables

-- Loop through all the tables in the database
FETCH NEXT
   FROM tables
   INTO @tablename

WHILE @@FETCH_STATUS = 0
BEGIN
-- Do the showcontig of all indexes of the table
   INSERT INTO @fraglist 
   EXEC ('DBCC SHOWCONTIG (''' + @tablename + ''') 
      WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS')
   FETCH NEXT
      FROM tables
      INTO @tablename
END

-- Close and deallocate the cursor
CLOSE tables
DEALLOCATE tables

-- Declare cursor for list of indexes to be defragged
DECLARE indexes CURSOR FOR
   SELECT ObjectName, ObjectId, IndexId, LogicalFrag
   FROM @fraglist
   WHERE LogicalFrag >= @maxfrag
      AND INDEXPROPERTY (ObjectId, IndexName, 'IndexDepth') > 0

-- Open the cursor
OPEN indexes

-- loop through the indexes
FETCH NEXT
   FROM indexes
   INTO @tablename, @objectid, @indexid, @frag

WHILE @@FETCH_STATUS = 0
BEGIN
   PRINT 'Executing DBCC INDEXDEFRAG (0, ' + RTRIM(@tablename) + ',
   ' + RTRIM(@indexid) + ') - fragmentation currently '
       + RTRIM(CONVERT(varchar(15),@frag)) + '%'
   SELECT @execstr = 'DBCC INDEXDEFRAG (0, ' + RTRIM(@objectid) + ',
   ' + RTRIM(@indexid) + ')'
   EXEC (@execstr)

   FETCH NEXT
      FROM indexes
      INTO @tablename, @objectid, @indexid, @frag
END

-- Close and deallocate the cursor
CLOSE indexes
DEALLOCATE indexes

GO

/* 
		H I S T O R Y
		
		6.00.00		02/20/2020  : Embed script in OpCon database (OPCON-12984)
*/