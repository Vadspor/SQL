USE mssql;


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
	FROM Readers, Books, ReadersTakingBook
	WHERE Readers.Ticket=ReadersTakingBook.Ticket
	AND ReadersTakingBook.BookID=Books.BookID
	GROUP BY PIB, Name, Price
	HAVING Price<
	(SELECT AVG(Price)
		FROM Books);



