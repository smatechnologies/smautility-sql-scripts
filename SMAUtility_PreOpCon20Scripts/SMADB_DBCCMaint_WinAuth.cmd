rem  Copyright (C) 2006-2011 by SMA
rem  All rights reserved

call .\SMA_SetDBMaintenanceScriptingVariables.cmd

sqlcmd -i .\SMADB_DBCCMaint.sql -S%OpConxpsSQLInstance% -E  -h-1 -b




