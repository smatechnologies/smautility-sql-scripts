rem  Copyright (C) 2003-2011 by SMA
rem  All rights reserved

call .\SMA_SetDBMaintenanceScriptingVariables.cmd

sqlcmd -i .\SMADB_Backup.sql -S%OpConxpsSQLInstance% -E  -h-1 -b


