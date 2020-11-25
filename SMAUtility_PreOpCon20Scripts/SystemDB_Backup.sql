/*
 Copyright (C) 2003-2011 by SMA
 All rights reserved
*/
:OUT $(SQLScriptOutputDirectory)SystemDB_Backup.log
USE master
GO

SET QUOTED_IDENTIFIER ON
BACKUP DATABASE master TO DISK = '$(PathToSystemDBBackupFile)' WITH INIT
BACKUP DATABASE msdb TO DISK = '$(PathToSystemDBBackupFile)' WITH NOINIT
if exists (select name from sysdatabases where name = 'distribution')
BEGIN
BACKUP DATABASE distribution TO DISK = '$(PathToSystemDBBackupFile)' WITH NOINIT
END
SET QUOTED_IDENTIFIER OFF

/* 
			H I S T O R Y 

     3.05.01  12/17/03  : Renamed SystemDBbackup.sql as SystemDB_Backup.sql and copyright added (SW# 7061)
     4.00.05  04/09/08  : Set path to backup folder to SQL Server 2005 default rather than SQL Server 2000 default (SW# 16727)
     4.10.01  05/26/09  : Introduce scripting variables (SW# 18471)
     5.00.00  11/30/10  : Remove the :Connect statement from the database maintenance sql files (US863: TA5341)
     5.00.02		08/29/2011	:	Set production version for OpCon 5.0 SP2


*/