<link id="linkstyle" rel='stylesheet' href='style.css'/>

SMAUtility Database Scripts
===========

The SMAUtility Schedule is a Schedule which is normally put in place when OpCon is initially installed and configured. The purpose of the Schedule is to automate basic maintenance items such as database backups. Many OpCon users have altered the SMAUtility Schedule over the years by either adding their own Jobs, or slightly modifing the Jobs SMA provided.

During the release of OpCon 20 the SMAUtility Schedule's database Jobs were modified to use Embedded Scripts instead of scripts which reside on the OpCon server. This made the login credentials more secure and provided a better user experience for new users. All new OpCon environments use the newer SMAUtility Schedule, but existing SMAUtility Schedules were not modified during the upgrade.

This repository provides two things:
1. **The old SMAUtility database scripts.** The older scripts will no longer be distributed with OpCon as of OpCon 21. If you prefer the older scrips to the embedded scripts you can pull the old scripts from this repository. 
2. **The new SMAUtility database scripts.** The OpCon database upgrade scripts do not modify existing SMAUtility Schedules. The new scripts as well as brief documentation on how to set them up can be found within this repository.
  

## Old SMA Utility Database Scripts
The **SMAUtility_PreOpCon20Scripts** folder contains all of the SMAUtility database scripts which were used in releases prior to OpCon 20. These scripts will no longer be distributed as of OpCon 21 but can be downloaded from this repository. If you decide to continue to use the older scripts, please move them to a new location (away from the rest of OpCon's database scripts).

## New SMA Utility Database Scripts
The **SMAUtility_OpCon20** folder contains the scripts which are used by the new SMAUtilty Schedule. The documentation below provides a command line and a screen shot of each of the Jobs.

**Note:** The Script Type and Script Runner must be created before updating your Jobs to use Embedded Scripts.

### Create the Script Type
The SQL Script Type was not created automatically unless the new SMAUtiltiy Schedule was loaded. You will need to create a script type which looks similar to the image below. 

![SQL Script Type](/img/ScriptType.PNG)

### Create the Script Runner
The SQL Script Runner was not created automatically unless the new SMAUtiltiy Schedule was loaded.
 
**Script Runner if running OpCon on Windows:**
![SQL Script Runner Windows](/img/ScriptRunnerWindows.PNG)

```
sqlcmd -i $FILE $ARGUMENTS
```

**Script Runner if running OpCon on Docker (Linux):**
![SQL Script Runner Linux](/img/ScriptRunnerLinux.PNG)

```
/opt/mssql-tools/bin/sqlcmd -i $FILE $ARGUMENTS
```

### Global Properties
A few Global Properties are referenced by the new Jobs. These need to be created for the Jobs to work properly.
1. DB_SERVER_NAME
    * <ins>Example</ins>: SQL-OpCon
2. DatabaseName
    * <ins>Example</ins>: OPCONXPS
3. SQLMaintUser
    * <ins>Example</ins>: sa
4. SQLMaintPassword 
    * <ins>Note</ins>: We recommend encrypting this Global Property)
5. PathToFullBackupFile
    * <ins>Example</ins>: C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\SMADB_Backup.bak
6. PathToTranLogBackupFile
    * <ins>Example</ins>: C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\SMATLog_Backup.bak


### SMA Check Identity Limit (SMA_CheckIdentityLimit.sql)
The SMA_CheckIdentityLimit.sql is called by the SMA Check Identity Limit Job. The command line is listed below for SQL Authentication.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -d [[DatabaseName]] -h-1 -b
```

The SMADB_Backup.sql is called by the SMA Databse Backup Job. The command line is listed below for Windows Authentication.
Note: The Batch user assigned to the job must be an Windows account DomainName\UserName and have SQL premissions for the Database.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -d [[DatabaseName]] -h-1 -b
```

##### Job Environment Variables for SMA Database Backup
Three environment variables are required for the SMA Database Backup Job. 

1. DatabaseName
    * <ins>Global Property</ins> [[DatabaseName]] is recommended for the value.

![Database Backup](/img/DatabaseBackup.png)

**Note:** The Runner will be slightly different depending on whether OpCon is running on Windows or Docker/Linux. If it is run on Windows it will look like this:

![Database Backup Runner](/img/WindowsRunner.PNG)


### SMA Database Backup (SMADB_Backup.sql)
The SMADB_Backup.sql is called by the SMA Databse Backup Job. The command line is listed below for SQL Authentication.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -h-1 -b
```

The SMADB_Backup.sql is called by the SMA Databse Backup Job. The command line is listed below for Windows Authentication.
Note: The Batch user assigned to the job must be an Windows account DomainName\UserName and have SQL premissions for the Database.

```
-S [[DB_SERVER_NAME]] -h-1 -b
```

##### Job Environment Variables for SMA Database Backup
Three environment variables are required for the SMA Database Backup Job. 

1. DatabaseName
    * <ins>Global Property</ins> [[DatabaseName]] is recommended for the value.
2. PathToFullBackupFile
    * <ins>Global Property</ins> [[PathToFullBackupFile]] is recommended for the value.
3. PathToTranLogBackupFile
    * <ins>Global Property</ins> [[PathToTranLogBackupFile]] is recommended for the value.

![Database Backup](/img/DatabaseBackup.png)

**Note:** The Runner will be slightly different depending on whether OpCon is running on Windows or Docker/Linux. If it is run on Windows it will look like this:

![Database Backup Runner](/img/WindowsRunner.PNG)

### SMA Database Transaction Log Backup (SMADB_TLog_Backup.sql)
The SMADB_TLog_Backup.sql is called by the SMA Database Transaction Log Backup Job. The command line is listed below for SQL Authentication.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -h-1 -b
```

The SMADB_TLog_Backup.sql is called by the SMA Database Transaction Log Backup Job. The command line is listed below for Windows Authentication.
Note: The Batch user assigned to the job must be an Windows account DomainName\UserName and have SQL premissions for the Database.

```.
-S [[DB_SERVER_NAME]] -h-1 -b
```

##### Job Environment Variables for SMA Database Transaction Log Backup
Two environment variables are required for the SMA Database Transaction Log Backup Job. 

1. DatabaseName
    * <ins>Global Property</ins> [[DatabaseName]] is recommended for the value.
2. PathToTranLogBackupFile
    * <ins>Global Property</ins> [[PathToTranLogBackupFile]] is recommended for the value.

![Database TLog Backup](/img/DatabaseTlogBackup.png)

**Note:** The Runner will be slightly different depending on whether OpCon is running on Windows or Docker/Linux. If it is run on Windows it will look like this:

![Database Tlog Backup Runner](/img/WindowsRunner.PNG)

### SMA Database Maintenance (SMA_DBCCMaint.sql)
The SMA_DBCCMaint.sql is called by the SMA Database Maintenance Job. The command line is listed below for SQL Authentication.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]]  -h-1 -b
```

The SMA_DBCCMaint.sql is called by the SMA Database Maintenance Job. The command line is listed below for Windows Authentication.
Note: The Batch user assigned to the job must be an Windows account DomainName\UserName and have SQL premissions for the Database.

```
-S [[DB_SERVER_NAME]] -h-1 -b
```

##### Job Environment Variables for SMA Database Maintenance
Only one environment variable is required for the SMA Database Maintenance Job. 

1. DatabaseName
    * <ins>Global Property</ins> [[DatabaseName]] is recommended for the value.

![Database Maintenance](/img/DatabaseMaintenance.png)

**Note:** The Runner will be slightly different depending on whether OpCon is running on Windows or Docker/Linux. If it is run on Windows it will look like this:

![Database Maintenance Runner](/img/WindowsRunner.PNG)

### SMA DBCC Index Defrag (SMA_DBCCIndexDefrag.sql)
The SMA_DBCCIndexDefrag.sql is called by the SMA DBCC Index Defrag Job. The command line is listed below for SQL Authentication.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -b
```

The SMA_DBCCIndexDefrag.sql is called by the SMA DBCC Index Defrag Job. The command line is listed below for Windows Authentication.
Note: The Batch user assigned to the job must be an Windows account DomainName\UserName and have SQL premissions for the Database.

```
-S [[DB_SERVER_NAME]] -b
```

##### Job Environment Variables for SMA DBCC Index Defrag
Only one environment variable is required for the SMA DBCC Index Defrag Job. 

1. DatabaseName
    * <ins>Global Property</ins> [[DatabaseName]] is recommended for the value.

![Database DBCC Index](/img/DatabaseDBCCIndex.png)

**Note:** The Runner will be slightly different depending on whether OpCon is running on Windows or Docker/Linux. If it is run on Windows it will look like this:

![Database DBCC Index Runner](/img/WindowsRunner.PNG)

### SMA Index Defragmentation (SMA_IndexDefragmentation.sql)
The SMA_IndexDefragmentation.sql is called by the SMA Index Defragmentation Job. The command line is listed below for SQL Authentication.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -b
```

The SMA_IndexDefragmentation.sql is called by the SMA Index Defragmentation Job. The command line is listed below for Windows Authentication.
Note: The Batch user assigned to the job must be an Windows account DomainName\UserName and have SQL premissions for the Database.

```
-S [[DB_SERVER_NAME]] -b
```

##### Job Environment Variables for SMA Index Defragmentation
Only one environment variable is required for the SMA Index Defragmentation Job. 

1. DatabaseName
    * <ins>Global Property</ins> [[DatabaseName]] is recommended for the value.

![Database Index Defragmentation](/img/DatabaseIndexDefragment.png)

**Note:** The Runner will be slightly different depending on whether OpCon is running on Windows or Docker/Linux. If it is run on Windows it will look like this:

![Database Index Degragment Runner](/img/WindowsRunner.PNG)

### SMA Job Average
It is recommended to replace this Job by the Server Option **SAM Calculates Job Averages**. As long as this value is set to True the Job Average will automatically be calculated.

![Job Average Server Option](/img/JobAverageServerOption.PNG)

If you prefer to continue to run the Job you can do so by executing the following command. No script is needed for this Job. The command line is listed below for SQL Authentication.

```
sqlcmd -S[[DB_SERVER_NAME]] -U[[SqlMaintUser]] -P[[SqlMaintPassword]] -Q"exec [[DatabaseName]].dbo.SMA_JOBAVG"
```

The command line is listed below for Windows Authentication.
Note: The Batch user assigned to the job must be an Windows account DomainName\UserName and have SQL premissions for the Database.
```
sqlcmd -S[[DB_SERVER_NAME]] -Q"exec [[DatabaseName]].dbo.SMA_JOBAVG"
```

![Job Average](/img/JobAverage.PNG)

# Disclaimer
No Support and No Warranty are provided by SMA Technologies for this project and related material. The use of this project's files is on your own risk.

SMA Technologies assumes no liability for damage caused by the usage of any of the files offered here via this Github repository.

# Prerequisites


# Instructions


# License
Copyright 2019 SMA Technologies

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Contributing
We love contributions, please read our [Contribution Guide](CONTRIBUTING.md) to get started!

# Code of Conduct
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code-of-conduct.md)
SMA Technologies has adopted the [Contributor Covenant](CODE_OF_CONDUCT.md) as its Code of Conduct, and we expect project participants to adhere to it. Please read the [full text](CODE_OF_CONDUCT.md) so that you can understand what actions will and will not be tolerated.
