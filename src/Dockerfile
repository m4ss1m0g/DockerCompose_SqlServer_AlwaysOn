FROM mcr.microsoft.com/mssql/server

COPY . /

USER root

# https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-ver15
RUN /opt/mssql/bin/mssql-conf set sqlagent.enabled true
RUN /opt/mssql/bin/mssql-conf set hadr.hadrenabled  1
RUN /opt/mssql/bin/mssql-conf set memory.memorylimitmb 2048

CMD /bin/bash ./startup.sh