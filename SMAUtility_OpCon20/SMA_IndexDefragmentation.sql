/*
This script is built from the sample code for an example of ALTER INDEX in SQL Server Books Online documentation.
It is therefore not under SMA Solutions copyright.
Indexes with less than 10% average fragmentation are ignored.
Indexes with average fragmentation between 10% and 30% are reorganized
Indexes with average fragmentation at 30% or greater are rebuilt
*/


USE  [$(DatabaseName)]
GO

SET NOCOUNT ON;

-- Declare variables
DECLARE @MAXFRAG float;

DECLARE @schemaname nvarchar(130);   
DECLARE @objectid int;  
DECLARE @objectname nvarchar(130);   
DECLARE @indexid int;  
DECLARE @indexname nvarchar(130);   
DECLARE @frag float;  
DECLARE @partitioncount bigint;  
DECLARE @partitionnum bigint;  
DECLARE @partitions bigint;  
DECLARE @command nvarchar(4000);   


-- Decide on the maximum fragmentation to allow
SET @MAXFRAG = 10.0

-- Conditionally select tables and indexes from the sys.dm_db_index_physical_stats function   
-- and convert object and index IDs to names.  
SELECT  
    object_id AS objectid,  
    index_id AS indexid,  
    partition_number AS partitionnum,  
    avg_fragmentation_in_percent AS frag  
INTO #work_to_do  
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED')  
WHERE avg_fragmentation_in_percent > @MAXFRAG AND index_id > 0;  

SELECT * FROM #work_to_do

-- Declare the cursor for the list of partitions to be processed.  
DECLARE partitions CURSOR FOR SELECT * FROM #work_to_do;  

-- Open the cursor.  
OPEN partitions;  

-- Loop through the partitions.  
WHILE (1=1)  
    BEGIN;  
        FETCH NEXT  
           FROM partitions  
           INTO @objectid, @indexid, @partitionnum, @frag;  
        IF @@FETCH_STATUS < 0 BREAK;  
        SELECT @objectname = QUOTENAME(o.name), @schemaname = QUOTENAME(s.name)  
        FROM sys.objects AS o  
        JOIN sys.schemas as s ON s.schema_id = o.schema_id  
        WHERE o.object_id = @objectid;  
        SELECT @indexname = QUOTENAME(name)  
        FROM sys.indexes  
        WHERE  object_id = @objectid AND index_id = @indexid;  
        SELECT @partitioncount = count (*)  
        FROM sys.partitions  
        WHERE object_id = @objectid AND index_id = @indexid;  

-- 30 is an arbitrary decision point at which to switch between reorganizing and rebuilding.  
        IF @frag < 30.0  
            SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REORGANIZE';  
        IF @frag >= 30.0  
            SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REBUILD';  
        IF @partitioncount > 1  
            SET @command = @command + N' PARTITION=' + CAST(@partitionnum AS nvarchar(10));  
		PRINT GETDATE();
        PRINT N'Executing: ' + @command;  
        EXEC (@command);  
    END;  

-- Close and deallocate the cursor.  
CLOSE partitions;  
DEALLOCATE partitions;  

-- Drop the temporary table.  
DROP TABLE #work_to_do;  
GO  

/* 
		H I S T O R Y 
		
		6.00.00		02/20/2020  : Embed script in OpCon database (OPCON-12984)
*/