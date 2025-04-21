USE mssql;

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'My_Love')
BEGIN
	CREATE LOGIN My_Love
		WITH PASSWORD = 'ilove',
		DEFAULT_DATABASE = mssql;
END;

GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'My_Love')
BEGIN
    CREATE USER My_Love FOR LOGIN My_Love;
END;

GO

EXECUTE sp_addsrvrolemember "My_Love", "sysadmin";

GO
SELECT * FROM sys.server_principals;
SELECT * FROM sys.database_principals;
SELECT IS_SRVROLEMEMBER('sysadmin', 'My_Love') AS IsSysadmin;
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Bill')
BEGIN
	CREATE LOGIN Bill
		WITH PASSWORD = 'Camaro',
		DEFAULT_DATABASE = mssql;
END;

GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Bill')
BEGIN
    CREATE USER Bill FOR LOGIN Bill;
END;

GO

IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Bill')
BEGIN
	GRANT EXEC ON CalculateValue TO Bill;
	REVOKE ALL TO Bill;
END;

GO

SELECT *
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##';

GO

IF NOT EXISTS (SELECT 1 
               FROM sys.symmetric_keys 
               WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'KeyForMyLove';
END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.certificates 
               WHERE name = 'CertifiLove')
BEGIN
    CREATE CERTIFICATE CertifiLove
    WITH SUBJECT = 'Protect Contact';
END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.symmetric_keys 
               WHERE name = 'KeyForMyLove')
BEGIN
    CREATE SYMMETRIC KEY KeyForMyLove 
    WITH ALGORITHM = AES_128 
    ENCRYPTION BY CERTIFICATE CertifiLove;
END;
GO

IF NOT EXISTS (SELECT 1 
               FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_NAME = 'Readers' 
                 AND COLUMN_NAME = 'EncryptContacts')
BEGIN
    ALTER TABLE Readers
    ADD EncryptContacts VARBINARY(MAX);
END;
GO

OPEN SYMMETRIC KEY KeyForMyLove 
DECRYPTION BY CERTIFICATE CertifiLove;
GO

UPDATE Readers
SET EncryptContacts = EncryptByKey (Key_GUID('KeyForMyLove'), Contacts)
FROM dbo.Readers;
GO

CLOSE SYMMETRIC KEY KeyForMyLove;
GO

SELECT * FROM Readers;

GO

OPEN SYMMETRIC KEY KeyForMyLove
DECRYPTION BY CERTIFICATE CertifiLove;

GO

SELECT 
Ticket, EncryptContacts,
CONVERT(varchar, DecryptByKey(EncryptContacts)) 
AS 'Decrypted Contacts'
FROM dbo.Readers;
 
CLOSE SYMMETRIC KEY KeyForMyLove;
GO




