USE kursova;
DROP TABLE IF EXISTS ReadersTakingBook;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Readers;
DROP TABLE IF EXISTS Halls;


GO

CREATE TABLE Books(
	Pressmark INT,
	Named VARCHAR(50) NOT NULL UNIQUE,
	Author VARCHAR(35) NOT NULL,
	Publisher VARCHAR(50) NOT NULL,
	PublicationDate SMALLDATETIME NOT NULL,
	Count1 INT NOT NULL,
	Count2 INT NOT NULL,
	Count3 INT NOT NULL,
	CONSTRAINT BooksPrimary  PRIMARY KEY (Pressmark),
);

CREATE TABLE Halls(
	HallID INT IDENTITY,
	Named VARCHAR(35) NOT NULL UNIQUE,
	Size INT NOT NULL,
	CONSTRAINT HallsPrimary PRIMARY KEY (HallID)
);

CREATE TABLE Readers(
	Ticket INT,
	PIB VARCHAR(50) NOT NULL UNIQUE,
	PasportID CHAR(9) NOT NULL UNIQUE,
	DateOfBirst SMALLDATETIME NOT NULL,
	Addressa VARCHAR(35) NOT NULL,
	PhoneNumber CHAR(9) NOT NULL UNIQUE,
	Science VARCHAR(50) NOT NULL,
	AcademicDegree VARCHAR(3) NOT NULL,
	HallID INT NOT NULL,
	DateInclude SMALLDATETIME NOT NULL,
	CONSTRAINT ReadersPrimary PRIMARY KEY (Ticket),
	CONSTRAINT AcademicDegreeCheck CHECK (AcademicDegree IN ('Yes', 'No')),
	CONSTRAINT HallsForeign FOREIGN KEY (HallID) REFERENCES Halls ON UPDATE CASCADE
);

CREATE TABLE ReadersTakingBook(
	IDBookReader INT IDENTITY,
	Pressmark INT NOT NULL,
	Ticket INT NOT NULL,
	IssueDate SMALLDATETIME NOT NULL,
	DateOfReceipt SMALLDATETIME,
	CONSTRAINT ReadersTakingBookPrimary PRIMARY KEY (IDBookReader),
	CONSTRAINT BooksForeign FOREIGN KEY (Pressmark) REFERENCES Books ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ReadersForeign FOREIGN KEY (Ticket) REFERENCES Readers ON DELETE CASCADE ON UPDATE CASCADE
);


GO


DROP TRIGGER IF EXISTS InsertedReadersTakingBooks
GO


CREATE TRIGGER InsertedReadersTakingBook
ON ReadersTakingBook
	INSTEAD OF INSERT
AS	
	DECLARE @Pressmark INT, @HallID INT;
	
    SELECT @Pressmark = Pressmark, @HallID = HallID FROM inserted I INNER JOIN Readers R ON I.Ticket = R.Ticket;

	IF (@HallID = 1 AND (SELECT COUNT1 FROM Books WHERE Pressmark = @Pressmark) > 0)
	BEGIN
		INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
		SELECT Pressmark, Ticket, IssueDate, DateOfReceipt 
		FROM inserted;
	END
	
	ELSE IF (@HallID = 2 AND (SELECT COUNT2 FROM Books WHERE Pressmark = @Pressmark) > 0)
	BEGIN
		INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
		SELECT Pressmark, Ticket, IssueDate, DateOfReceipt 
		FROM inserted;
	END
	ELSE IF (@HallID = 3 AND (SELECT COUNT3 FROM Books WHERE Pressmark = @Pressmark) > 0)
	BEGIN
		INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
		SELECT Pressmark, Ticket, IssueDate, DateOfReceipt 
		FROM inserted;
	END
	ELSE
	BEGIN
        RAISERROR('There is no book in this room.', 16, 1)
		ROLLBACK TRAN;
    END
GO


DROP TRIGGER IF EXISTS CheckIssueDateBeforeDateInclude;

GO
CREATE TRIGGER CheckIssueDateBeforeDateInclude
ON ReadersTakingBook
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 'TRUE'
        FROM inserted I
        INNER JOIN Readers R ON I.Ticket = R.Ticket
        WHERE I.IssueDate <= R.DateInclude
    )
    BEGIN
        RAISERROR('IssueDate must be later than DateInclude for the reader.', 16, 1);
        ROLLBACK TRANSACTION; 
    END
END
GO


DROP TRIGGER IF EXISTS CheckDelete;
GO

CREATE TRIGGER CheckDelete
ON Readers
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 'TRUE'
        FROM deleted D
        INNER JOIN ReadersTakingBook RTB ON D.Ticket = RTB.Ticket
		WHERE RTB.DateOfReceipt IS NULL
    )
    BEGIN
        RAISERROR('Cannot delete reader because they have borrowed books.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Readers
        WHERE Ticket IN (SELECT Ticket FROM deleted);
    END
END
GO



INSERT INTO Halls (Named, Size)
VALUES
	('Study Room', 28),
	('Innovation Hub', 15),
	('Quiet Room', 35)


INSERT INTO Readers (Ticket, PIB, PasportID, DateOfBirst, Addressa, PhoneNumber, Science, AcademicDegree, HallID, DateInclude)
VALUES 
	(1, 'Bychok Vadym Viacheslavovych', '977577586', '2005-08-14', 'Kyiv, Ukraine', '050123456', 'Secondary', 'No', 1, '2022-08-14'),
	(2, 'Pylypchuk Nazar Sergiyovich', '681860980', '1977-01-28', 'Lviv, Ukraine', '093123456', 'Higher', 'Yes', 2, '2021-11-17'),
	(3, 'Lushuck Denis Yuriyovich', '555404640', '2003-03-18', 'Odessa, Ukraine', '067123456', 'Secondary', 'No', 3, '2023-01-10'),
	(4, 'Kravchenko Oleksandr Volodymyrovych', '987654321', '1990-05-12', 'Kharkiv, Ukraine', '099123456', 'Higher', 'Yes', 3, '2022-03-24'),
	(5, 'Shevchenko Kateryna Ivanivna', '501234567', '2011-08-16', 'Dnipro, Ukraine', '044123456', 'Primary' , 'No', 1, '2022-05-22'),
	(6, 'Hryshchenko Yuriy Petrovych', '931112233', '2001-06-19', 'Vinnytsia, Ukraine', '095123456', 'Higher', 'Yes',  2, '2022-09-21'),
	(7, 'Ivanenko Svitlana Olegivna', '677556677', '1970-03-20', 'Zhytomyr, Ukraine', '066123456', 'Higher', 'Yes', 2, '2022-12-07'), 
	(8, 'Bondarenko Oksana Mykolaivna', '503456789', '1998-04-01', 'Rivne, Ukraine', '095123457', 'Higher', 'No', 3, '2023-02-11'),
	(9, 'Koval Andriy Serhiyovych', '632223344', '1984-12-10', 'Cherkasy, Ukraine', '067123457', 'Higher', 'Yes', 2, '2023-01-16'), 
	(10, 'Lytvynenko Halyna Volodymyrivna', '931009900', '2014-04-30', 'Khmelnytskyi, Ukraine', '063123456', 'Primary', 'No', 1, '2021-10-03'), 
	(11, 'Mykhailenko Artem Ihorovych', '931212121', '2006-10-17', 'Ivano-Frankivsk, Ukraine', '099123457', 'Secondary', 'No', 1, '2022-01-01'), 
	(12, 'Stasiuk Petro Volodymyrovych', '977878787', '2008-01-22', 'Zaporizhzhia, Ukraine' , '050123457', 'Secondary', 'No', 1, '2020-12-10'), 
	(13, 'Vasylenko Anastasiya Viktorivna', '999998877', '2000-11-03', 'Sumy, Ukraine', '073123456', 'Higher', 'Yes', 2, '2021-06-29'),
	(14, 'Horshenin Volodymyr Viktorovych', '993398127', '2003-03-11', 'Kuiv, Ukraine', '073489764', 'Higher', 'No', 2, '2019-12-21'),
	(15, 'Ivanenko Ivan Ivanovivh', '674566887', '1988-02-22', 'Zhytomyr, Ukraine', '000125606', 'Higher', 'Yes', 2, '2018-12-07'),
	(16, 'Petrenko Petro Petrovych', '468213894', '1997-07-07', 'Lytsk, Ukraine', '843761259', 'Higher', 'No', 2, '2024-11-25');


INSERT INTO Books (Pressmark, Named, Author, Publisher, PublicationDate, Count1, Count2, Count3)
VALUES 
	(1, 'METRO 2033', 'Dmytro Oleksiiovych Hlukhovskyi', 'Eksmo', '2005-08-14', 12, 9, 8),
	(2, 'The Witcher', 'Andrzej Sapkowski', 'SuperNowa', '1990-07-21', 10, 8, 6),
	(3, 'God of War', 'J. M. Barlog', 'Sony Press', '2018-06-05', 14, 13, 10),
	(4, '1984', 'George Orwell', 'Secker & Warburg', '1949-06-08', 13, 12, 7),
	(5,'The Hobbit', 'J.R.R. Tolkien', 'Allen & Unwin', '1937-09-21', 8, 7, 6),
	(6, 'The Shining', 'Stephen King', 'Doubleday', '1977-01-28', 12, 10, 7),
	(7, 'The Handmaid''s Tale', 'Margaret Atwood', 'McClelland & Stewart', '1985-04-01', 11, 9, 8),
	(8, 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', '1960-07-11', 9, 8, 7),
	(9, 'The Da Vinci Code', 'Dan Brown', 'Doubleday', '2003-03-18', 14, 12, 10),
	(10,'American Gods', 'Neil Gaiman', 'HarperCollins', '2001-06-19', 13, 12, 8),
	(11, 'A Brief History of Humankind', 'Yuval Noah Harari', 'Harvill Secker', '2011-09-04', 12, 10, 9),
	(12, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Charles Scribner''s Sons', '1925-04-10', 10, 9, 8),
	(13, 'Ready Player One', 'Ernest Cline', 'Crown Publishing', '2011-08-16', 9, 7, 6),
	(14, 'War and Peace', 'Leo Tolstoy', 'The Russian Messenger', '1969-03-04', 12, 11, 9),
	(15, 'Crime and Punishment', 'Fyodor Dostoevsky', 'The Russian Messenger', '1966-01-01', 11, 10, 8),
	(16, 'Twenty Thousand Leagues Under Sea', 'Jules Verne', 'Pierre-Jules Hetzel', '1970-03-20', 12, 10, 8),
	(17, 'Foundation', 'Isaac Asimov', 'Gnome Press', '1951-08-21', 14, 13, 9),
	(18, 'Fahrenheit 451', 'Ray Bradbury', 'Ballantine Books', '1953-10-19', 11, 9, 7),
	(19, 'Dune', 'Frank Herbert', 'Chilton Books', '1965-08-01', 13, 11, 9),
	(20, 'The War of the Worlds', 'H.G. Wells', 'Heinemann', '1998-04-01', 10, 9, 7),
	(21, 'Brave New World', 'Aldous Huxley', 'Chatto & Windus', '1932-12-31', 11, 10, 8),
	(22, 'Frankenstein', 'Mary Shelley', 'Lackington, Hughes, Harding, Mavor & Jones', '1918-01-01', 12, 10, 9),
	(23, 'The Iliad', 'Homer', 'Ancient Greece', '1910-01-06', 13, 12, 11),
	(24, 'The Odyssey', 'Homer', 'Ancient Greece', '1920-07-11', 13, 12, 11),
	(25, 'Pride and Prejudice', 'Jane Austen', 'T. Egerton', '1913-01-28', 14, 13, 12),
	(26,'Jane Eyre', 'Charlotte Bronte', 'Smith, Elder & Co.', '1947-10-16', 11, 10, 8),
	(27, 'Wuthering Heights', 'Emily Bronte', 'Thomas Cautley Newby', '1947-12-01', 12, 11, 10),
	(28, 'A Tale of Two Cities', 'Charles Dickens', 'Chapman & Hall', '1959-04-30', 13, 11, 9),
	(29, 'The Adventures of Huckleberry Finn', 'Mark Twain', 'Chatto & Windus', '1984-12-10', 11, 10, 8),
	(30,'Les Misérables', 'Victor Hugo', 'A. Lacroix, Verboeckhoven & Cie.', '1962-06-01', 9, 8, 7),
	(31, 'One Hundred Years of Solitude', 'Gabriel Garcia Marquez', 'Editorial Sudamericana', '1967-05-30', 10, 9, 8),
	(32, 'The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company', '1951-07-16', 0, 1, 1),
	(33, 'The', 'J', 'Little', '1914-03-26', 0, 0, 0),
	(34, 'TheN', 'JOHN', 'Lile', '1999-12-11', 1, 4, 3),
	(35, 'The2', 'J', 'Little', '1917-06-27', 3, 1, 4),
	(36, 'TheN2', 'JOHN', 'Lile', '1999-12-11', 1, 4, 3),
	(37, 'Zen4', 'AMD', 'AMD64', '1999-12-11', 2, 2, 2),
	(39, 'METRO EXODUS', 'Dmytro Oleksiiovych Hlukhovskyi', 'Eksmo', '2019-11-24', 10, 5, 18);






--Triger1 - InsertedReadersTakingBook
--INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
--VALUES (33, 15, '2024-12-07 12:00:00');

--Triger2 - CheckIssueDateBeforeDateInclude
--INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
--VALUES (1, 16, '2024-10-01 12:00:00');


INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (1, 1, '2024-10-01 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (36, 1, '2024-10-01 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (2, 2, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (3, 3, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (5, 6, '2024-10-04 09:30:00', '2024-10-08 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (6, 7, '2024-10-05 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (7, 10, '2024-10-07 12:00:00', '2024-10-11 15:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (8, 11, '2024-10-08 14:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (9, 12, '2024-10-09 10:00:00', '2024-10-13 11:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (1, 1, '2023-01-15 08:45:00', '2023-02-15 10:15:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (2, 2, '2023-03-01 09:20:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (3, 3, '2023-04-10 14:35:00', '2023-05-10 11:50:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (4, 4, '2023-06-01 10:00:00', '2023-06-30 16:25:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (5, 5, '2023-07-15 08:15:00', '2023-08-15 13:40:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (6, 6, '2023-09-01 09:55:00', '2023-09-20 15:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (7, 7, '2023-10-01 12:00:00', '2023-10-25 17:45:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (8, 8, '2023-11-01 14:30:00', '2023-11-30 09:20:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (9, 9, '2023-12-10 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (10, 10, '2024-01-01 11:15:00', '2024-01-28 14:50:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (11, 11, '2024-02-15 13:20:00', '2024-03-10 08:40:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (12, 12, '2024-03-05 09:05:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (13, 13, '2024-04-01 10:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (14, 1, '2024-05-15 14:10:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (15, 2, '2024-06-01 11:45:00', '2024-06-30 09:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (16, 3, '2024-07-01 08:20:00', '2024-07-30 15:55:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (17, 4, '2024-08-01 10:10:00', '2024-08-25 16:40:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (18, 5, '2024-09-05 09:35:00', '2024-10-05 14:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (19, 6, '2024-10-01 10:25:00', '2024-10-28 17:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (20, 7, '2024-11-01 13:15:00', '2024-11-30 10:10:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (21, 8, '2024-12-05 08:40:00', '2024-01-05 16:35:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (22, 9, '2024-12-10 14:20:00', '2024-01-10 11:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (23, 10, '2024-01-01 09:55:00', '2024-01-28 15:25:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (24, 11, '2024-02-01 08:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (25, 12, '2024-03-01 16:15:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (26, 13, '2024-04-01 11:50:00', '2024-05-01 10:25:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (27, 1, '2024-05-01 09:10:00', '2024-05-25 17:20:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (28, 2, '2024-06-01 14:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (29, 3, '2024-07-01 10:05:00', '2024-07-30 16:50:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (30, 4, '2024-08-01 08:50:00', '2024-08-25 15:10:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (31, 5, '2024-09-05 12:00:00', '2024-10-05 14:35:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (32, 6, '2024-10-01 09:45:00', '2024-10-28 13:50:00');



INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (1, 2, '2024-10-01 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (1, 4, '2024-10-01 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (1, 9, '2024-10-01 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (1, 12, '2024-10-01 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (1, 6, '2024-10-01 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (2, 8, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (2, 6, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (2, 1, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (2, 3, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (3, 1, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (3, 2, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (3, 4, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (5, 3, '2024-10-04 09:30:00', '2024-10-08 12:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (6, 2, '2024-10-05 16:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (7, 11, '2024-10-07 12:00:00', '2024-10-11 15:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate)
VALUES (8, 12, '2024-10-08 14:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt)
VALUES (9, 1, '2024-10-09 10:00:00', '2024-10-13 11:00:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (1, 3, '2023-01-15 08:45:00', '2023-02-15 14:30:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (2, 5, '2023-03-01 11:20:00');

INSERT ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (3, 6, '2023-04-10 09:10:00', '2023-05-10 17:40:00');



INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (4, 10, '2023-06-01 08:23', '2023-06-30 15:45');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (5, 12, '2023-07-15 09:14', '2023-08-15 17:30');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (6, 7, '2023-09-01 10:05', '2023-09-20 13:25');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (7, 9, '2023-10-01 11:35', '2023-10-25 16:50');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (8, 5, '2023-11-01 08:47', '2023-11-30 14:12');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (9, 4, '2023-12-10 08:56');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (10, 3, '2024-01-01 09:22', '2024-01-28 17:03');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (11, 4, '2024-02-15 10:43', '2024-03-10 12:55');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (12, 2, '2024-03-05 08:30');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (13, 11, '2024-04-01 11:50');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (14, 6, '2024-05-15 13:10');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (15, 7, '2024-06-01 15:00', '2024-06-30 16:05');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (16, 6, '2024-07-01 08:20', '2024-07-30 14:40');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (17, 7, '2024-08-01 12:25', '2024-08-25 10:30');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (18, 3, '2024-09-05 09:10', '2024-10-05 16:00');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (19, 9, '2024-10-01 10:45', '2024-10-28 13:05');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (20, 12, '2024-11-01 12:30', '2024-11-30 17:20');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (21, 6, '2024-12-05 14:05', '2024-01-05 11:25');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (22, 1, '2024-12-10 10:50', '2024-01-10 12:15');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (23, 1, '2024-01-01 13:40', '2024-01-28 15:30');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (24, 9, '2024-02-01 16:00');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (25, 4, '2024-03-01 09:55');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (26, 9, '2024-04-01 14:30', '2024-05-01 11:00');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (27, 11, '2024-05-01 12:40', '2024-05-25 16:10');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate) 
VALUES (28, 3, '2024-06-01 08:05');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (29, 10, '2024-07-01 10:25', '2024-07-30 13:00');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (30, 6, '2024-08-01 11:15', '2024-08-25 12:30');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (31, 7, '2024-09-05 16:05', '2024-10-05 09:30');

INSERT INTO ReadersTakingBook (Pressmark, Ticket, IssueDate, DateOfReceipt) 
VALUES (32, 3, '2024-10-01 08:50', '2024-10-28 17:00');


GO


DROP PROC IF EXISTS BooksInReaders;
GO


CREATE PROC BooksInReaders @RDR VARCHAR(35) 
AS
	SELECT Named, PIB
	FROM Books B INNER JOIN ReadersTakingBook RTB 
	ON B.Pressmark = RTB.Pressmark
	INNER JOIN Readers R
	ON RTB.Ticket= R.Ticket
	WHERE PIB = @RDR
	AND DateOfReceipt IS NOT NULL;
GO


--EXEC BooksInReaders 'Bychok Vadym Viacheslavovych';
GO

DROP PROC IF EXISTS PressmarkNamed;
GO


CREATE PROC PressmarkNamed @PM VARCHAR(35) 
AS
	SELECT Pressmark, Named 
	FROM Books b
	WHERE Pressmark = @PM;
GO


--EXEC PressmarkNamed 2
GO


DROP PROC IF EXISTS NamedPressmark
GO


CREATE PROC NamedPressmark @NM VARCHAR(35) 
AS
	SELECT Pressmark, Named 
	FROM Books b
	WHERE Named = @NM;
GO


--EXEC NamedPressmark 'METRO 2033'
GO


DROP PROC IF EXISTS DateBookReader;
GO


CREATE PROC DateBookReader @BOOK VARCHAR(35), @READER VARCHAR(35)
AS
	SELECT Named, PIB, IssueDate
	FROM Books B INNER JOIN ReadersTakingBook RTB 
	ON B.Pressmark = RTB.Pressmark
	INNER JOIN Readers R
	ON RTB.Ticket= R.Ticket
	WHERE B.Named = @BOOK
	AND R.PIB = @READER;
GO


--EXEC DateBookReader 'METRO 2033', 'Bychok Vadym Viacheslavovych';
GO


--DROP PROC IF EXISTS MonthsReader;
DROP VIEW IF EXISTS MonthsReader;
GO


CREATE VIEW MonthsReader
AS
	SELECT Named, PIB, IssueDate
	FROM Books B INNER JOIN ReadersTakingBook RTB 
	ON B.Pressmark = RTB.Pressmark
	INNER JOIN Readers R
	ON RTB.Ticket = R.Ticket
	WHERE RTB.IssueDate < DATEADD(MONTH, -1, GETDATE())
	AND RTB.DateOfReceipt IS NOT NULL;
GO


--SELECT * FROM MonthsReader
GO 


--SELECT Named, PIB, IssueDate, HallID, B.Pressmark, R.Ticket
--FROM Books B INNER JOIN ReadersTakingBook RTB 
--ON B.Pressmark = RTB.Pressmark
--INNER JOIN Readers R
--ON RTB.Ticket = R.Ticket
--WHERE Named = 'The Catcher in the Rye'
--AND RTB.DateOfReceipt IS NOT NULL;
--GO


--DROP PROC IF EXISTS CountBooks2;
DROP VIEW IF EXISTS CountBooks2;
GO


CREATE VIEW CountBooks2
AS
	SELECT Named, PIB, IssueDate
	FROM Books B INNER JOIN ReadersTakingBook RTB 
	ON B.Pressmark = RTB.Pressmark
	INNER JOIN Readers R
	ON RTB.Ticket = R.Ticket
	WHERE B.Pressmark IN (SELECT Pressmark
					FROM Books
					WHERE (Count1 + Count2 + Count3) <= 2)
	AND RTB.DateOfReceipt IS NOT NULL;
GO 


--SELECT * FROM CountBooks2;
GO


--DROP PROC IF EXISTS CountAllReaders;
DROP VIEW IF EXISTS CountAllReaders;
GO
	

CREATE VIEW CountAllReaders
AS 
	SELECT COUNT(*) AS All_Readers
	FROM Readers;
GO


--SELECT * FROM CountAllReaders;
GO


--DROP PROC IF EXISTS ReadersYounger20;
DROP VIEW IF EXISTS ReadersYounger20;
GO
	

CREATE VIEW ReadersYounger20
AS 
	SELECT PIB, DateOfBirst
	FROM Readers
	WHERE DateOfBirst > DATEADD(YEAR, -20, GETDATE());
GO


--SELECT * FROM ReadersYounger20;
GO


--DROP PROC IF EXISTS ProcentScience;
DROP VIEW IF EXISTS ProcentScience;
GO


CREATE VIEW ProcentScience
AS
	SELECT Science,
			COUNT(*) AS CountOfReaders,
			(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Readers)) AS Percentage
	FROM Readers
	GROUP BY Science;
GO


--SELECT * FROM ProcentScience;
GO


DROP VIEW IF EXISTS ReadersWhoDont;
GO

CREATE VIEW ReadersWhoDont
AS
SELECT R.*
FROM Readers R
WHERE NOT EXISTS (
    SELECT 1
    FROM ReadersTakingBook RTB
    WHERE RTB.Ticket = R.Ticket AND RTB.DateOfReceipt IS NULL
);
GO


DROP PROC IF EXISTS DeleteMoreYear;
GO


CREATE PROC DeleteMoreYear @Ticket VARCHAR(50)
AS
	DELETE FROM Readers
	WHERE DateInclude < DATEADD(YEAR, -3, GETDATE()) 
	AND Ticket = @Ticket;
GO


--SELECT * FROM ReadersWhoDont;
--EXEC DeleteMoreYear 10
--SELECT * FROM ReadersWhoDont;

GO


DROP TABLE IF EXISTS RERegistrationBuffer;
DROP PROC IF EXISTS RERegistration;
GO


CREATE PROC RERegistration @R INT
AS 
	UPDATE Readers SET Ticket = Ticket + 100 WHERE Ticket = @R;
GO


--SELECT * FROM Readers;
--EXEC RERegistration 8;
--SELECT * FROM Readers;
--GO


DROP PROC IF EXISTS REClasification;
GO

CREATE PROC REClasification @B INT
AS 
	UPDATE Books SET Pressmark = Pressmark + 1000  WHERE Pressmark = @B
GO


--SELECT * FROM Books
--WHERE Pressmark = 1;
--EXEC REClasification 1
--SELECT * FROM Books;
GO


DROP PROC IF EXISTS DeleteOldBooks;
GO


CREATE PROC DeleteOldBooks @OB INT
AS
	IF @OB IN (
			SELECT B.Pressmark
			FROM Books B 
			INNER JOIN ReadersTakingBook RTB ON B.Pressmark = RTB.Pressmark 
			INNER JOIN Readers R ON RTB.Ticket = R.Ticket
			WHERE RTB.DateOfReceipt IS NULL
			AND PIB IS NOT NULL)
		BEGIN
			--PRINT('Can`t delete book if she isset in readers!!!')
			RAISERROR('Can`t delete book if she isset in readers!!!', 16, 1);
		END;
	ELSE
		BEGIN
			IF @OB IN (
					SELECT Pressmark
					FROM Books 
					WHERE Count1 + Count2 + Count3 = 0)
				OR @OB IN (
					SELECT Pressmark
					FROM Books 
					WHERE PublicationDate < DATEADD(YEAR, -75, GETDATE()))
				BEGIN
					DELETE FROM Books
					WHERE Pressmark = @OB; 
				END;
			ELSE
				BEGIN
					--PRINT('The book is not lost or old')
					RAISERROR('The book is not lost or old', 16, 1);
			END;
		END;
GO

--SELECT * FROM Books;
--EXEC DeleteOldBooks 33; 
--GO
--EXEC DeleteOldBooks 1; 
--GO
--EXEC DeleteOldBooks 34; 
--GO
--EXEC DeleteOldBooks 35; 
--GO
--EXEC DeleteOldBooks 36; 
--GO
--EXEC DeleteOldBooks 37; 
--GO
--SELECT * FROM Books; 
--GO


DROP PROC IF EXISTS CountBooksAuthHall;
GO


GO
CREATE PROC CountBooksAuthHall @A VARCHAR(50), @Hall INT
AS
	SELECT Author, 
		CASE 
            WHEN @Hall = 1 THEN SUM(Count1)
            WHEN @Hall = 2 THEN SUM(Count2)
            WHEN @Hall = 3 THEN SUM(Count3)
			ELSE 0
		END AS TotalBooks
	FROM Books
    WHERE Author = @A
	GROUP BY Author;
GO

--SELECT * FROM Books WHERE Author = 'Dmytro Oleksiiovych Hlukhovskyi';
--EXEC CountBooksAuthHall 'Dmytro Oleksiiovych Hlukhovskyi', 2;
GO

DROP VIEW IF EXISTS ReportM;
GO

CREATE VIEW ReportM
AS
	SELECT 'BooksHalls1' Metric, SUM(Count1) AS Value FROM Books
	UNION ALL SELECT 'BooksHalls2', SUM(Count2) FROM Books
	UNION ALL SELECT 'BooksHalls3', SUM(Count3)  FROM Books
	UNION ALL SELECT 'TotalBooks', CAST(SUM(Count1 + Count2 + Count3) AS INT) FROM Books
	UNION ALL SELECT 'ReadersHall1', COUNT(*) FROM Readers WHERE HallID = 1
	UNION ALL SELECT 'ReadersHall2', COUNT(*) FROM Readers WHERE HallID = 2
	UNION ALL SELECT 'ReadersHall3', COUNT(*) FROM Readers WHERE HallID = 3
	UNION ALL SELECT 'TotalReaders', COUNT(*) FROM Readers
	UNION ALL SELECT 'NewReaders', COUNT(*) FROM Readers WHERE DateInclude > DATEADD(MONTH, -1, GETDATE())
    UNION ALL SELECT 'BooksIssuedLastMonth', COUNT(*) AS Value FROM ReadersTakingBook RTB INNER JOIN Books B ON B.Pressmark = RTB.Pressmark
	WHERE RTB.IssueDate > DATEADD(MONTH, -1, GETDATE())
	UNION ALL SELECT 'COUNT BOOKS ISSUED THIS MONTH:',  (SELECT COUNT(*) AS Value FROM ReadersTakingBook RTB INNER JOIN Books B ON B.Pressmark = RTB.Pressmark
    WHERE RTB.IssueDate > DATEADD(MONTH, -1, GETDATE()))
	UNION ALL SELECT B.Named, COUNT(*) AS Value FROM ReadersTakingBook RTB INNER JOIN Books B ON B.Pressmark = RTB.Pressmark
    WHERE RTB.IssueDate > DATEADD(MONTH, -1, GETDATE()) GROUP BY B.Named
	UNION ALL SELECT 'READERS WHO DIDNT TAKE BOOKS LAST MONTH AND THEIR HallID', (SELECT COUNT(*) AS Value FROM Readers 
	WHERE PIB NOT IN (SELECT PIB FROM Readers R INNER JOIN ReadersTakingBook RTB ON R.Ticket = RTB.Ticket WHERE RTB.IssueDate > DATEADD(MONTH, -1, GETDATE())))
	UNION ALL SELECT PIB, HallID FROM Readers WHERE PIB NOT IN (SELECT PIB FROM Readers R INNER JOIN ReadersTakingBook RTB ON R.Ticket = RTB.Ticket 
	WHERE RTB.IssueDate > DATEADD(MONTH, -1, GETDATE()))
	;
GO

--SELECT * FROM ReportM;



IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Librarian')
BEGIN
	CREATE LOGIN Librarian
		WITH PASSWORD = 'kursova',
		DEFAULT_DATABASE = kursova;
		CREATE USER Librarian FOR LOGIN Librarian;
END;

GRANT SELECT ON SCHEMA::dbo TO Librarian;
GRANT INSERT ON dbo.Readers TO Librarian;
GRANT INSERT, DELETE ON dbo.Books TO Librarian;
GRANT INSERT ON dbo.ReadersTakingBook TO Librarian;

GRANT EXEC ON BooksInReaders TO Librarian;
GRANT EXEC ON DateBookReader TO Librarian;
GRANT EXEC ON NamedPressmark TO Librarian;
GRANT EXEC ON PressmarkNamed TO Librarian;
GRANT EXEC ON DeleteMoreYear TO Librarian;
GRANT EXEC ON RERegistration TO Librarian;
GRANT EXEC ON REClasification TO Librarian;
GRANT EXEC ON DeleteOldBooks TO Librarian;
GRANT EXEC ON CountBooksAuthHall TO Librarian;
GO




--SELECT * FROM ReadersWhoDont;

--DELETE FROM Readers WHERE Ticket = 1;
--GO
--DELETE FROM Readers WHERE Ticket = 10;

--SELECT * FROM ReadersWhoDont;


--SELECT * FROM Readers;
--SELECT * FROM Books;
--SELECT * FROM Halls;
--SELECT * FROM ReadersTakingBook;



