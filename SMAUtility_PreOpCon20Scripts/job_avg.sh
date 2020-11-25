#!/bin/bash

sqlcmd -S ${DB_SERVER_NAME} -U $1 -P $2 -Q"exec ${DatabaseName}.dbo.SMA_JOBAVG" > /app/log/SMA_JOBAVG.txt
