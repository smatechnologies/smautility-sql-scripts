#!/bin/bash

sqlcmd -i /app/Database/SMADB_DBCCMaint.sql -S ${DB_SERVER_NAME} -U $1 -P $2  -h-1 -b
