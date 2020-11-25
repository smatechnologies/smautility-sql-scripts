rem  Copyright (C) 2003-2009 by SMA
rem  All rights reserved

call .\SMA_SetDBEnvironmentScriptingVariables.cmd

sqlcmd -S%OpConxpsSQLInstance% -Uopconsam -P%opconsamDefault% -Q"exec %DatabaseName%.dbo.SMA_JOBAVG" > SMA_JOBAVG.txt