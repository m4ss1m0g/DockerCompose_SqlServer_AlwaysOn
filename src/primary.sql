-- PRIMARY
USE [master]
GO

-- Create masterkey
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@ssw0rd!';
GO

-- Create certificate
CREATE CERTIFICATE ao_certificate WITH SUBJECT = 'ao_certificate';
GO

BACKUP CERTIFICATE ao_certificate
TO FILE = '/var/opt/mssql/shared/ao_certificate.cert'
WITH PRIVATE KEY (
        FILE = '/var/opt/mssql/shared/ao_certificate.key',
        ENCRYPTION BY PASSWORD = 'P@ssw0rd!'
    );
GO

-- Create HADR endpoint on port 5022
CREATE ENDPOINT [ao_endpoint]
STATE=STARTED
AS TCP (
    LISTENER_PORT = 5022,
    LISTENER_IP = ALL
)
FOR DATA_MIRRORING (
    ROLE = ALL,
    AUTHENTICATION = CERTIFICATE ao_certificate,
    ENCRYPTION = REQUIRED ALGORITHM AES
)
GO