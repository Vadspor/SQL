USE mssql;
DROP TRIGGER IF EXISTS DeletingBook;

ALTER TABLE ReadersTakingBook
	DROP CONSTRAINT IF EXISTS BooksForeign;

ALTER TABLE ReadersTakingBook
	ADD CONSTRAINT BooksForeign 
	FOREIGN KEY (BookID) 
	REFERENCES Books
	ON DELETE CASCADE;

GO

CREATE TRIGGER DeletingBook
	ON Books
	INSTEAD OF DELETE
AS 
BEGIN
    PRINT 'Trigger executed';
	
	SELECT * 
    FROM deleted;

	IF EXISTS 
	(SELECT 1
	FROM deleted
	INNER JOIN ReadersTakingBook 
	ON deleted.BookID = ReadersTakingBook.BookID
	WHERE ReadersTakingBook.DateOfReceipt IS NULL)
	BEGIN 
	RAISERROR('Can`t delete book if she isset in readers!!!', 16, 1)
		ROLLBACK TRAN; 
	END
	    ELSE
    BEGIN
        DELETE FROM Books
        WHERE BookID IN (SELECT BookID FROM deleted)
	END;
END;

GO
SELECT * FROM Books
	WHERE BookID = 8;

SELECT * FROM ReadersTakingBook
	WHERE BookID = 8;


DELETE FROM Books 
	WHERE BookID = 8;

GO

SELECT Name, Books.BookID, IssueDate, DateOfReceipt
FROM Books
INNER JOIN ReadersTakingBook
ON Books.BookID = ReadersTakingBook.BookID
WHERE ReadersTakingBook.DateOfReceipt IS NULL
AND Books.BookID = 8;


SELECT * 
FROM ReadersTakingBook
WHERE BookID = 8 AND DateOfReceipt IS NULL;


SELECT * FROM Books
	WHERE BookID = 8;

SELECT * FROM ReadersTakingBook
	WHERE BookID = 8;




SELECT * FROM Books;
SELECT * FROM ReadersTakingBook;



GO




DROP TRIGGER IF EXISTS UpdateBooks;
DROP TRIGGER IF EXISTS InsertBooks;
DROP VIEW IF EXISTS ViewRarities;


GO

CREATE VIEW ViewRarities
AS
SELECT 
	BookID, 
	Name, 
	Date,
	Price * POWER(1.05, YEAR(GETDATE()) - YEAR(Date)) AS RedemptionPrice
FROM Books;

GO

CREATE TRIGGER InsertBooks
	ON Books
	FOR INSERT
AS
BEGIN
	SET IDENTITY_INSERT Rarities ON;
    INSERT INTO Rarities (BookID, Author, Name, Date, Price, IfNew, WhatAbout, RedemptionPrice)
    SELECT i.BookID, i.Author, i.Name, i.Date, i.Price, i.IfNew, i.WhatAbout, i.Price * POWER(1.05, YEAR(GETDATE()) - YEAR(i.Date))
    FROM inserted i
    WHERE i.Date < '1980-01-01';
END;

GO
CREATE TRIGGER UpdateBooks
	ON Books
	FOR UPDATE
AS
BEGIN
	UPDATE Rarities
	SET Author = i.Author,
	Name = i.Name,
	Date = i.Date,
	Price = i.Price, 
	IfNew = i.IfNew,
	WhatAbout = i.WhatAbout,
	RedemptionPrice = i.Price * POWER(1.05, YEAR(GETDATE()) - YEAR(Rarities.Date))
    FROM Rarities
    INNER JOIN inserted i ON Rarities.BookID = i.BookID;
	END;

GO


DELETE FROM Books WHERE Name = '0';
DELETE FROM Books WHERE Name = '1';

DELETE FROM Rarities WHERE Name = '0';
DELETE FROM Rarities WHERE Name = '1';



GO
INSERT Books (Author, Name, Date, Price, IfNew, WhatAbout) 
VALUES ('0', '0', '1970-01-01', 10000, 'No', '000000000000000000000000');

INSERT Books (Author, Name, Date, Price, IfNew, WhatAbout) 
VALUES ('1', '1', '1970-01-01', 10000, 'No', '000000000000000000000000');

SELECT * FROM Books;

SELECT * FROM Rarities

--UPDATE Books SET Price = 0 WHERE BookID = 4;
