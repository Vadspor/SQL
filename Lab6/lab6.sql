use library;
DROP VIEW IF EXISTS BooksInReaders;
DROP VIEW IF EXISTS ReaderIssueDate;
DROP VIEW IF EXISTS BooksForTicket;
DROP VIEW IF EXISTS BooksInReadersTOP;
GO

CREATE VIEW BooksForTicket AS
SELECT Name, Author, Date, IssueDate, DateOfReceipt, Ticket
	FROM Books INNER JOIN ReadersTakingBook 
	ON Books.BookID=ReadersTakingBook.BookID
	WHERE ReadersTakingBook.Ticket=1
	GROUP BY Name, Author, Date, IssueDate, DateOfReceipt, Ticket;
GO

CREATE VIEW BooksInReaders AS
SELECT PIB, IssueDate, DateOfReceipt
	FROM ReadersTakingBook, Readers, Books
	WHERE Readers.Ticket=ReadersTakingBook.Ticket
	AND ReadersTakingBook.BookID=Books.BookID
	GROUP BY PIB, IssueDate, DateOfReceipt, Name
	HAVING Name='METRO 2033';
GO

CREATE VIEW ReaderIssueDate AS
SELECT PIB, IssueDate, DateOfReceipt
	FROM ReadersTakingBook, Readers 
	WHERE ReadersTakingBook.Ticket=Readers.Ticket
	AND IssueDate='2024-10-04 09:30:00';
GO

CREATE VIEW BooksInReadersTOP AS 
SELECT TOP 5 Author, Name, COUNT(ReadersTakingBook.BookID) Demand
	FROM Books INNER JOIN ReadersTakingBook 
	ON Books.BookID=ReadersTakingBook.BookID
	WHERE Ticket IS NOT NULL
	GROUP BY Author, Name
	ORDER BY Demand DESC;
GO

select * From BooksForTicket;
select * From BooksInReaders;
select * From ReaderIssueDate;
select * From BooksInReadersTOP;


