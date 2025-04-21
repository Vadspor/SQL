USE mssql;
--DROP VIEW IF EXISTS Rarities;
DROP TABLE IF EXISTS Rarities;
DROP PROCEDURE IF EXISTS CalculateValue;
DROP PROCEDURE IF EXISTS CalculateValue1;

--SELECT * FROM Readers;
--SELECT * FROM ReadersTakingBook;

GO 

SELECT *, Price AS RedemptionPrice 
	INTO Rarities
	FROM Books
	WHERE Books.Date < '1980-01-01';

GO

CREATE PROCEDURE CalculateValue
AS
	UPDATE Rarities
		SET RedemptionPrice = Price * POWER(1.05, YEAR(GETDATE()) - YEAR(Date));

GO

CREATE PROCEDURE CalculateValue1
AS
	UPDATE Rarities
		SET RedemptionPrice = Price * (1 + 0.05 * (YEAR(GETDATE()) - YEAR(Date)));

GO

EXEC CalculateValue1
SELECT * FROM Rarities

EXEC CalculateValue
SELECT * FROM Rarities

SELECT * FROM Books;