-- SECONDARY
USE [master]
GO

-- Create master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@ssw0rd!';
GO

-- create certificate with private key created on primary server and saved to shared location
CREATE CERTIFICATE ao_certificate
    FROM FILE = '/var/opt/mssql/shared/ao_certificate.cert'
    WITH PRIVATE KEY (
    FILE = '/var/opt/mssql/shared/ao_certificate.key',
    DECRYPTION BY PASSWORD = 'P@ssw0rd!'
)
GO

--create HADR endpoint
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