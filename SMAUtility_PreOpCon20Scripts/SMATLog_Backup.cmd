rem  Copyright (C) 2003-2011 by SMA
rem  All rights reserved

call .\SMA_SetDBMaintenanceScriptingVariables.cmd

sqlcmd -i .\SMATlog_Backup.sql -S%OpConxpsSQLInstance% -U%DBBackupOperator% -P%DBBackupkey%  -h-1 -b

