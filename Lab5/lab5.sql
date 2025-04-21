USE library;

ALTER TABLE Readers
	DROP COLUMN IF EXISTS CountBooks;

ALTER TABLE Readers
	ADD CountBooks INT;

UPDATE Readers
	SET CountBooks = 
		(SELECT COUNT(Books.Ticket)
		FROM Books
		WHERE Books.Ticket=Readers.Ticket);

select * from Books;
select * from Readers;

SELECT PIB, CountBooks
	FROM Readers;

SELECT PIB, CountBooks, AVG(CountBooks) AVGCountBooks
	FROM Readers
	GROUP BY PIB, CountBooks;

	SELECT PIB, CountBooks, AVG(CountBooks) AVGCountBooks
	FROM Readers
	GROUP BY PIB, CountBooks
	HAVING CountBooks>AVG(CountBooks);

	SELECT PIB, CountBooks, AVG(CountBooks) AVGCountBooks
	FROM Readers
	GROUP BY PIB, CountBooks
	HAVING CountBooks>=AVG(CountBooks);

SELECT PIB, CountBooks 
	FROM Readers
	GROUP BY PIB, CountBooks
	HAVING CountBooks>
	(SELECT AVG(CountBooks)
	FROM Readers);

SELECT PIB, CountBooks
	FROM Readers
	GROUP BY PIB, CountBooks
	HAVING CountBooks=
	(SELECT MAX(CountBooks)
	FROM Readers);

SELECT PIB, Name, Price
	FROM Readers, Books
	WHERE Readers.Ticket=Books.Ticket
	GROUP BY PIB, Name, Price
	HAVING Price<
	(SELECT AVG(Price)
		FROM Books);

	
	
	




	

	