/*
 Copyright (C) 2003-2020 by SMA
 All rights reserved
*/

USE [$(DatabaseName)]
GO
SET QUOTED_IDENTIFIER ON
GO
BACKUP DATABASE [$(DatabaseName)] TO DISK = '$(PathToFullBackupFile)' WITH INIT
GO
BACKUP LOG [$(DatabaseName)] TO DISK = '$(PathToTranLogBackupFile)' WITH NOINIT
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
		H I S T O R Y 
		
		3.05.01		12/17/03	: Renamed OpConTLogbackup.sql as SMATLog_Backup.sql and copyright added (SW# 7061)
		4.00.05		04/09/08	: Set path to backup folder to SQL Server 2005 default rather than SQL Server 2000 default (SW# 16727)
		4.10.01		05/26/09	: Introduce scripting variables (SW# 18471)
		5.00.00		11/30/10	: Remove the :Connect statement from the database maintenance sql files (US863: TA5341)
		5.00.01.01	08/15/11	: Enclose $(DatabaseName) scripting variable in square brackets ([]) (DE1875: TA7838)
		5.00.01.02	08/17/11	: Remove double quotes from [$(DatabaseName)] scripting variable (DE1875: TA7838)
		5.00.02		08/29/2011	: Set production version for OpCon 5.0 SP2
		6.00.00		02/20/2020	: Embed script in OpCon database (OPCON-12984)
*/