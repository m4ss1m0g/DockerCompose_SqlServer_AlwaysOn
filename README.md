# DockerCompose_SqlServer_AlwaysOn

Contains scripts for creating a SqlServer AlwaysOn cluster with Docker.
This script create two machine with SQL Server Developer Edition on the same docker subnet.
Communications between the server is made by a shared certificate created on shared folder `/var/opt/mssql/shared`, same thing for the backup shared folder `/var/opt/mssql/backup`

## Install

Clone repo and open a command prompt inside folder.

Build image

``` bash
docker-compose build
```

Launch machines

``` bash
docker-compose up -d
```

## Setup

The dbs servers listening on:

- Db1 port 9001
- Db2 port 9002

Open SSMS and connect to `localhost, 9001` or `9002`

## Know issues

- When creating the Always On cluster with the SSMS UI the generated address contains the `.DOMAIN` suffix that must be removed
- The linux version of SQL Server don't have the _Managent Plan_. See [here](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-release-notes?view=sql-server-2017#known-issues)
