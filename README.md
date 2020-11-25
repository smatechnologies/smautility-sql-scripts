<link id="linkstyle" rel='stylesheet' href='style.css'/>

SMAUtility Database Scripts
===========

The SMAUtility Schedule is a Schedule which is normally put in place when OpCon is initially installed and configured. The purpose of the Schedule is to automate basic maintenance items such as database backups. Many OpCon users have altered the SMAUtility Schedule over the year either adding their own Jobs, or slightly modifing the Jobs SMA provided.

During the release of OpCon 20 the SMAUtility Schedule's database Jobs were modified to use Embedded Scripts instead of scripts which reside on the OpCon server. This made the login credentials more secure and provided a better user experience for new users. All new OpCon environments use the newer SMAUtility Schedule, but existing OpCon environments keep the SMAUtility Schedules it had in place. 

This repo provides to things:
1. The old SMAUtility database scripts.
2. The new SMAUtility database scripts.

This document provides a description of the OpCon jobs calling the embedded scripts.    

## SMAUtility_PreOpCon20Scripts
This folder contains all of the SMAUtility database scripts which were used in releases prior to OpCon 20. These scripts will no longer be distributed start with OpCon 21, but will continue to be available in the Innovation Lab. 

## SMAUtility_OpCon20
This folder contains the scripts which are used by the new SMAUtilty Schedule.

### SMADB_Backup.sql (SMA Database Backup)
The SMADB_Backup.sql is called by the SMA Databse Backup Job. The command line is listed below.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -h-1 -b
```
![Database Backup](/img/DatabaseBackup.png)

### SMADB_TLog_Backup.sql (SMA Database Transaction Log Backup)
The SMADB_TLog_Backup.sql is called by the SMA Database Transaction Log Backup Job. The command line is listed below.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -h-1 -b
```
![Database TLog Backup](/img/DatabaseTlogBackup.png)

### SMA_DBCCMaint.sql (SMA Database Maintenance)
The SMA_DBCCMaint.sql is called by the SMA Database Maintenance Job. The command line is listed below.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]]  -h-1 -b
```

![Database Maintenance](/img/DatabaseMaintenance.png)

### SMA_DBCCIndexDefrag.sql (SMA DBCC Index Defrag)
The SMA_DBCCIndexDefrag.sql is called by the SMA DBCC Index Defrag Job. The command line is listed below.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -b
```

![Database DBCC Index](/img/DatabaseDBCCIndex.png)

### SMA_IndexDefragmentation.sql (SMA Index Defragmentation)
The SMA_IndexDefragmentation.sql is called by the SMA Index Defragmentation Job. The command line is listed below.

```
-S [[DB_SERVER_NAME]] -U [[SQLMaintUser]] -P [[SQLMaintPassword]] -b
```
![Database Index Defragmentation](/img/DatabaseIndexDefragment.png)

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