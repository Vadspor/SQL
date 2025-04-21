USE mssql;
DROP TABLE IF EXISTS ReadersTakingBook;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Readers;


CREATE TABLE Readers
	(Ticket INT IDENTITY,
	PIB VARCHAR(35),
	Contacts VARCHAR(35),
	Email VARCHAR(35),
	CountBooks INT,
	CONSTRAINT ReadersPrimary PRIMARY KEY (Ticket)
	);

CREATE TABLE Books
	(BookID INT IDENTITY,
	Author VARCHAR(35) NOT NULL,
	Name VARCHAR(35) NOT NULL,
	Date smalldatetime NOT NULL,
	Price INT NOT NULL,
	IfNew VARCHAR(3) NOT NULL,
	WhatAbout VARCHAR(1000) NOT NULL,
	CONSTRAINT BooksPrimary  PRIMARY KEY (BookID),
	CONSTRAINT IfNewCheck CHECK (IfNew IN ('Yes', 'No'))
	);


CREATE TABLE ReadersTakingBook(
	IDBookReader INT IDENTITY,
	BookID INT,
	Ticket INT,
	IssueDate SMALLDATETIME,
	DateOfReceipt SMALLDATETIME,
	CONSTRAINT ReadersTakingBookPrimary PRIMARY KEY (IDBookReader),
	CONSTRAINT BooksForeign FOREIGN KEY (BookID) REFERENCES Books,
	CONSTRAINT ReadersForeign FOREIGN KEY (Ticket) REFERENCES Readers);



Insert Readers (PIB, Contacts, Email) values ('Bychok Vadym Viacheslavovych', '+380977577586', 'bichok.vv@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Pylypchuk Nazar Sergiyovich', '+38068186098', 'pylypserg@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Lushuck Denis Yuriyovich', '+38055540464', 'lisik@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Kravchenko Oleksandr Volodymyrovych', '+380987654321', 'krav.ov@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Shevchenko Kateryna Ivanivna', '+380501234567', 'shev@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Hryshchenko Yuriy Petrovych', '+380931112233', 'hrysh.yp@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Ivanenko Svitlana Olegivna', '+380677556677', 'ivan.so@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Bondarenko Oksana Mykolaivna', '+380503456789', 'bond@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Koval Andriy Serhiyovych', '+380632223344', 'koval@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Lytvynenko Halyna Volodymyrivna', '+380931009900', 'lytvyn@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Mykhailenko Artem Ihorovych', '+380931212121', 'mykhail.ai@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Stasiuk Petro Volodymyrovych', '+380977878787', 'stasiuk.pv@gmail.com');
Insert Readers (PIB, Contacts, Email) values ('Vasylenko Anastasiya Viktorivna', '+380999998877', 'vasyl.av@gmail.com')


Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Dmytro Oleksiiovych Hlukhovskyi', 'METRO 2033', '2005-08-14', 381, 'No', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Andrzej Sapkowski', 'The Witcher', '1990-07-21', 460, 'No', 'The books have been described as having a cult following in Poland and throughout Central and Eastern Europe...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('J. M. Barlog', 'God of War', '2018-06-05', 583, 'Yes', 'His vengeance against the Gods of Olympus years behind him...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('George Orwell', '1984', '1949-06-08', 320, 'No', 'A dystopian social science fiction novel...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('J.R.R. Tolkien', 'The Hobbit', '1937-09-21', 410, 'No', 'A fantasy novel that serves as a prelude to The Lord of the Rings...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Stephen King', 'The Shining', '1977-01-28', 450, 'No', 'A horror novel...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Margaret Atwood', 'The Handmaid''s Tale', '1985-04-01', 350, 'No', 'A dystopian novel set in a theocratic society...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Harper Lee', 'To Kill a Mockingbird', '1960-07-11', 300, 'No', 'A novel set in the American South...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Dan Brown', 'The Da Vinci Code', '2003-03-18', 520, 'No', 'A mystery thriller novel...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Neil Gaiman', 'American Gods', '2001-06-19', 470, 'No', 'A fantasy novel exploring the conflict between the old gods of mythology...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Yuval Noah Harari', 'A Brief History of Humankind', '2011-09-04', 530, 'No', 'A popular science book that chronicles the history of humankind...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('F. Scott Fitzgerald', 'The Great Gatsby', '1925-04-10', 290, 'No', 'A novel set in the Jazz Age...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Ernest Cline', 'Ready Player One', '2011-08-16', 490, 'Yes', 'A science fiction novel set in a dystopian future...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Leo Tolstoy', 'War and Peace', '1969-03-04', 600, 'No', 'A historical novel about Russian society during the Napoleonic wars...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Fyodor Dostoevsky', 'Crime and Punishment', '1966-01-01', 480, 'No', 'A philosophical novel exploring morality and redemption...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Jules Verne', 'Twenty Thousand Leagues Under Sea', '1970-03-20', 350, 'No', 'A classic science fiction adventure novel about Captain Nemo...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Isaac Asimov', 'Foundation', '1951-08-21', 390, 'No', 'A science fiction novel about the fall of a galactic empire...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Ray Bradbury', 'Fahrenheit 451', '1953-10-19', 320, 'No', 'A dystopian novel about censorship and the dangers of oppressive regimes...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Frank Herbert', 'Dune', '1965-08-01', 450, 'No', 'A science fiction epic set on the desert planet Arrakis...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('H.G. Wells', 'The War of the Worlds', '1998-04-01', 300, 'No', 'A novel about an alien invasion of Earth...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Aldous Huxley', 'Brave New World', '1932-12-31', 350, 'No', 'A dystopian novel about a future society driven by technology and social control...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Mary Shelley', 'Frankenstein', '1918-01-01', 310, 'No', 'A gothic novel about the creation of a monster by scientist Victor Frankenstein...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Homer', 'The Iliad', '1910-01-06', 400, 'No', 'An ancient Greek epic poem recounting the events of the Trojan War...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Homer', 'The Odyssey', '1920-07-11', 400, 'No', 'An ancient Greek epic poem following Odysseus''s journey home after the Trojan War...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Jane Austen', 'Pride and Prejudice', '1913-01-28', 250, 'No', 'A classic novel of manners exploring themes of love, class, and morality...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Charlotte Bronte', 'Jane Eyre', '1947-10-16', 300, 'No', 'A novel about the moral and spiritual development of the title character, Jane Eyre...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Emily Bronte', 'Wuthering Heights', '1947-12-01', 290, 'No', 'A novel about the destructive relationship between Heathcliff and Catherine Earnshaw...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Charles Dickens', 'A Tale of Two Cities', '1959-04-30', 280, 'No', 'A novel set during the French Revolution, exploring themes of sacrifice and redemption...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Mark Twain', 'The Adventures of Huckleberry Finn', '1984-12-10', 320, 'No', 'A novel about the adventures of a young boy and an escaped slave traveling down the Mississippi River...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Victor Hugo', 'Les Misérables', '1962-06-01', 550, 'No', 'A historical novel exploring themes of justice, mercy, and redemption in post-revolutionary France...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Gabriel Garcia Marquez', 'One Hundred Years of Solitude', '1967-05-30', 370, 'No', 'A multi-generational story exploring the history of the Buendía family and the fictional town of Macondo...');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('J.D. Salinger', 'The Catcher in the Rye', '1951-07-16', 340, 'No', 'A novel about teenage rebellion and alienation, told through the eyes of the protagonist, Holden Caulfield...');


Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (1, 1, '2024-10-01 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (2, 2, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (3, 3, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (5, 6, '2024-10-04 09:30:00', '2024-10-08 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (6, 7, '2024-10-05 16:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (7, 10, '2024-10-07 12:00:00', '2024-10-11 15:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (8, 11, '2024-10-08 14:30:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (9, 12, '2024-10-09 10:00:00', '2024-10-13 11:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (1, 1, '2023-01-15', '2023-02-15');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (2, 2, '2023-03-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (3, 3, '2023-04-10', '2023-05-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (4, 4, '2023-06-01', '2023-06-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (5, 5, '2023-07-15', '2023-08-15');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (6, 6, '2023-09-01', '2023-09-20');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (7, 7, '2023-10-01', '2023-10-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (8, 8, '2023-11-01', '2023-11-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (9, 9, '2023-12-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (10, 10, '2024-01-01', '2024-01-28');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (11, 11, '2024-02-15', '2024-03-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (12, 12, '2024-03-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (13, 13, '2024-04-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (14, 1, '2024-05-15');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (15, 2, '2024-06-01', '2024-06-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (16, 3, '2024-07-01', '2024-07-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (17, 4, '2024-08-01', '2024-08-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (18, 5, '2024-09-05', '2024-10-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (19, 6, '2024-10-01', '2024-10-28');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (20, 7, '2024-11-01', '2024-11-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (21, 8, '2024-12-05', '2025-01-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (22, 9, '2024-12-10', '2025-01-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (23, 10, '2025-01-01', '2025-01-28');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (24, 11, '2025-02-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (25, 12, '2025-03-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (26, 13, '2025-04-01', '2025-05-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (27, 1, '2025-05-01', '2025-05-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (28, 2, '2025-06-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (29, 3, '2025-07-01', '2025-07-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (30, 4, '2025-08-01', '2025-08-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (31, 5, '2025-09-05', '2025-10-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (32, 6, '2025-10-01', '2025-10-28');




Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (1, 2, '2024-10-01 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (1, 4, '2024-10-01 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (1, 9, '2024-10-01 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (1, 12, '2024-10-01 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (1, 6, '2024-10-01 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (2, 8, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (2, 6, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (2, 1, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (2, 3, '2024-10-02 13:00:00', '2024-10-06 16:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (3, 1, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (3, 2, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (3, 4, '2024-10-03 15:00:00', '2024-10-07 10:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (5, 3, '2024-10-04 09:30:00', '2024-10-08 12:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (6, 2, '2024-10-05 16:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (7, 11, '2024-10-07 12:00:00', '2024-10-11 15:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate)
values (8, 12, '2024-10-08 14:30:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt)
values (9, 1, '2024-10-09 10:00:00', '2024-10-13 11:00:00');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (1, 3, '2023-01-15', '2023-02-15');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (2, 5, '2023-03-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (3, 6, '2023-04-10', '2023-05-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (4, 10, '2023-06-01', '2023-06-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (5, 12, '2023-07-15', '2023-08-15');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (6, 7, '2023-09-01', '2023-09-20');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (7, 9, '2023-10-01', '2023-10-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (8, 5, '2023-11-01', '2023-11-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (9, 4, '2023-12-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (10, 3, '2024-01-01', '2024-01-28');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (11, 4, '2024-02-15', '2024-03-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (12, 2, '2024-03-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (13, 11, '2024-04-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (14, 6, '2024-05-15');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (15, 7, '2024-06-01', '2024-06-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (16, 6, '2024-07-01', '2024-07-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (17, 7, '2024-08-01', '2024-08-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (18, 3, '2024-09-05', '2024-10-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (19, 9, '2024-10-01', '2024-10-28');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (20, 12, '2024-11-01', '2024-11-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (21, 6, '2024-12-05', '2025-01-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (22, 1, '2024-12-10', '2025-01-10');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (23, 1, '2025-01-01', '2025-01-28');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (24, 9, '2025-02-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (25, 4, '2025-03-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (26, 9, '2025-04-01', '2025-05-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (27, 11, '2025-05-01', '2025-05-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate) 
values (28, 3, '2025-06-01');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (29, 10, '2025-07-01', '2025-07-30');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (30, 6, '2025-08-01', '2025-08-25');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (31, 7, '2025-09-05', '2025-10-05');

Insert ReadersTakingBook (BookID, Ticket, IssueDate, DateOfReceipt) 
values (32, 3, '2025-10-01', '2025-10-28');



UPDATE Readers
	SET CountBooks = 
		(SELECT COUNT(ReadersTakingBook.Ticket)
		FROM ReadersTakingBook
		WHERE ReadersTakingBook.Ticket=Readers.Ticket);



SELECT * FROM Books;
SELECT * FROM Readers;
SELECT * FROM ReadersTakingBook;

SELECT Name, Author, Date, IssueDate, DateOfReceipt, Ticket
	FROM Books, ReadersTakingBook 
	WHERE Books.BookID=ReadersTakingBook.BookID
	GROUP BY Name, Author, Date, IssueDate, DateOfReceipt, Ticket
	HAVING ReadersTakingBook.Ticket=1;

SELECT Name, Author, Date, IssueDate, DateOfReceipt, Ticket
	FROM Books INNER JOIN ReadersTakingBook 
	ON Books.BookID=ReadersTakingBook.BookID
	WHERE ReadersTakingBook.Ticket=1
	GROUP BY Name, Author, Date, IssueDate, DateOfReceipt, Ticket;

SELECT PIB, IssueDate, DateOfReceipt
	FROM ReadersTakingBook INNER JOIN Readers
	ON ReadersTakingBook.Ticket=Readers.Ticket
	WHERE BookID=1
	GROUP BY PIB, IssueDate, DateOfReceipt;

SELECT PIB, IssueDate, DateOfReceipt
	FROM ReadersTakingBook, Readers 
	WHERE ReadersTakingBook.Ticket=Readers.Ticket
	AND IssueDate='2024-10-04 09:30:00';

SELECT TOP 3 Author, Name, COUNT(ReadersTakingBook.BookID) Demand
	FROM Books INNER JOIN ReadersTakingBook 
	ON Books.BookID=ReadersTakingBook.BookID
	WHERE Ticket IS NOT NULL
	GROUP BY Author, Name
	ORDER BY Demand DESC;
