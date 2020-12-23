rem ----  Scripting Variables used for OpCon/xps database maintenance ---

call "%~dp0SMA_SetDBEnvironmentScriptingVariables.cmd"

rem ----  Backup and Restore related scripting variables ----
SET PathToFullBackupFile=C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\SMADB_Backup.bak
SET PathToTranLogBackupFile=C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\SMATLog_Backup.bak
SET FullBackupFilename=SMADB_Backup.bak
SET TranLogBackupFilename=SMATLog_Backup.bak
SET DBBackupOperator=opconsam
SET DBBackupKey=0pC0nxp$
SET DBRestoreOperator=sa
SET DBRestoreKey=0pC0nxp$

SET PathToSystemDBBackupFile=C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\SystemDB_Backup.bak
SET SystemDBBackupFilename=SystemDB_Backup.bak



