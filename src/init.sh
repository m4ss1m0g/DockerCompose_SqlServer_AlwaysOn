FILE=/var/opt/mssql/initialized

# Setup SQL Server backupdir equals to compose file volume
/opt/mssql/bin/mssql-conf set filelocation.defaultbackupdir /var/opt/mssql/backup

# If file exists system is already initialized, skip
if [ ! -f $FILE ]; then
    # This is first time, initialize system

    # Docker compose DO NOT REMOVE volumes
    # Use docker-compose down -v --rmi all
    # https://docs.docker.com/compose/reference/down/
    if [ "$(ls -A /var/opt/mssql/shared)" ] && [ "$NAME" = "db1" ]; then
        echo " ====> Shared folder IS NOT EMPTY; deleting certificates.... <===="
        rm -fr /var/opt/mssql/shared/*
    fi

    # Wait different times between servers to create certificate
    # on primary and shared with second
    SLEEP_TIME=$INIT_WAIT
    SQL_SCRIPT=$INIT_SCRIPT

    echo "====> Initialize system "
    echo "====> Sleeping for ${SLEEP_TIME} seconds and wait for sql server to came up..."
    sleep ${SLEEP_TIME}

    # Execute the initialization script
    echo "====> Executing script"
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i $SQL_SCRIPT

    # Create a semaphore
    touch $FILE
fi
