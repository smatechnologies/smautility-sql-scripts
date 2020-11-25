/*
 Copyright (C) 2006-2020 by SMA
 All rights reserved
*/

USE  [$(DatabaseName)]
GO
DBCC CHECKDB 
GO
DBCC CHECKALLOC 
GO

/* 
		H I S T O R Y 
		
		4.10.01		05/26/09	: Introduce scripting variables (SW# 18471)
		5.00.00		11/30/10	: Remove the :Connect statement from the database maintenance sql files (US863: TA5341)
		5.00.01.01	08/15/11	: Enclose $(DatabaseName) scripting variable in square brackets ([]) (DE1875: TA7838)
		5.00.02		08/29/2011	: Set production version for OpCon 5.0 SP2
		6.00.00		02/20/2020  : Embed script in OpCon database (OPCON-12984)
*/