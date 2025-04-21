USE library;

DELETE FROM Books;
DELETE FROM Readers;

ALTER TABLE Books
	DROP COLUMN IF EXISTS IssueDate;

ALTER TABLE Books
	DROP COLUMN IF EXISTS DateOfReceipt;

ALTER TABLE Readers
	DROP CONSTRAINT IF EXISTS SingDefault;

ALTER TABLE Readers
	DROP COLUMN IF EXISTS Single;

ALTER TABLE Readers
	DROP COLUMN IF EXISTS email;

 ALTER TABLE Books
	DROP CONSTRAINT IF EXISTS BooksPrimary;

 ALTER TABLE Books
	DROP COLUMN IF EXISTS IDBookReader;

ALTER TABLE Books
    DROP CONSTRAINT IF EXISTS BooksFoKey;

ALTER TABLE Books
    ALTER COLUMN Ticket INT NULL;

ALTER TABLE Books
    ADD CONSTRAINT BooksFoKey FOREIGN KEY (Ticket) REFERENCES Readers(Ticket) ON DELETE SET NULL;

ALTER TABLE Books
	DROP CONSTRAINT IF EXISTS BooksPrimary;

 ALTER TABLE Books
	ADD IDBookReader INT IDENTITY;

ALTER TABLE Readers
	ADD email VARCHAR(35);

ALTER TABLE Books 
	ADD CONSTRAINT BooksPrimary PRIMARY KEY (IDBookReader);

ALTER TABLE Books
	ALTER COLUMN Date DATE;

ALTER TABLE Books
	ADD IssueDate SMALLDATETIME;

ALTER TABLE Books
	ADD DateOfReceipt SMALLDATETIME;


--ALTER TABLE Books
--	ADD CONSTRAINT Ticket, Author, Name, Date, Price, IfNew, WhatAbout UNIQUE

Insert Readers (PIB, Contacts, email, Ticket) values ('Bychok Vadym Viacheslavovych', '+380977577586', 'bichok.vv@gmail.com', 1);
Insert Readers (PIB, Contacts, email, Ticket) values ('Pylypchuk Nazar Sergiyovich', '+38068186098', 'pylypserg@gmail.com', 2);
Insert Readers (PIB, Contacts, email, Ticket) values ('Lushuck Denis Yuriyovich', '+38055540464', 'lisik@gmail.com', 3);
Insert Readers (PIB, Contacts, email, Ticket) values ('Kravchenko Oleksandr Volodymyrovych', '+380987654321', 'krav.ov@gmail.com', 4);
Insert Readers (PIB, Contacts, email, Ticket) values ('Shevchenko Kateryna Ivanivna', '+380501234567', 'shev@gmail.com', 5);
Insert Readers (PIB, Contacts, email, Ticket) values ('Hryshchenko Yuriy Petrovych', '+380931112233', 'hrysh.yp@gmail.com', 6);
Insert Readers (PIB, Contacts, email, Ticket) values ('Ivanenko Svitlana Olegivna', '+380677556677', 'ivan.so@gmail.com', 7);
Insert Readers (PIB, Contacts, email, Ticket) values ('Bondarenko Oksana Mykolaivna', '+380503456789', 'bond@gmail.com', 8);
Insert Readers (PIB, Contacts, email, Ticket) values ('Koval Andriy Serhiyovych', '+380632223344', 'koval@gmail.com', 9);
Insert Readers (PIB, Contacts, email, Ticket) values ('Lytvynenko Halyna Volodymyrivna', '+380931009900', 'lytvyn@gmail.com', 10);
Insert Readers (PIB, Contacts, email, Ticket) values ('Mykhailenko Artem Ihorovych', '+380931212121', 'mykhail.ai@gmail.com', 11);
Insert Readers (PIB, Contacts, email, Ticket) values ('Stasiuk Petro Volodymyrovych', '+380977878787', 'stasiuk.pv@gmail.com', 12);
Insert Readers (PIB, Contacts, email, Ticket) values ('Vasylenko Anastasiya Viktorivna', '+380999998877', 'vasyl.av@gmail.com', 13)


-- Вставка з обома датами
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (1, 'Dmytro Oleksiiovych Hlukhovskyi', 'METRO 2033', '2005-08-14', 381, 'No', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia', '2024-10-01 12:00:00', '2024-10-05 14:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (2, 'Andrzej Sapkowski', 'The Witcher', '1990-07-21', 460, 'No', 'The books have been described as having a cult following in Poland and throughout Central and Eastern Europe...', '2024-10-02 13:00:00', '2024-10-06 16:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (3, 'J. M. Barlog', 'God of War', '2018-06-05', 583, 'Yes', 'His vengeance against the Gods of Olympus years behind him...', '2024-10-03 15:00:00', '2024-10-07 10:00:00');

-- Вставка без Ticket
Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('George Orwell', '1984', '1949-06-08', 320, 'No', 'A dystopian social science fiction novel...');

-- Вставка з обома датами
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (6, 'J.R.R. Tolkien', 'The Hobbit', '1937-09-21', 410, 'No', 'A fantasy novel that serves as a prelude to The Lord of the Rings...', '2024-10-04 09:30:00', '2024-10-08 12:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (7, 'Stephen King', 'The Shining', '1977-01-28', 450, 'No', 'A horror novel...', '2024-10-05 16:00:00', '2024-10-09 14:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (8, 'Margaret Atwood', 'The Handmaid''s Tale', '1985-04-01', 350, 'No', 'A dystopian novel set in a theocratic society...', '2024-10-06 10:30:00');

-- Вставка без Ticket
Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('Harper Lee', 'To Kill a Mockingbird', '1960-07-11', 300, 'No', 'A novel set in the American South...');

-- Вставка з обома датами
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (10, 'Dan Brown', 'The Da Vinci Code', '2003-03-18', 520, 'No', 'A mystery thriller novel...', '2024-10-07 12:00:00', '2024-10-11 15:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (11, 'Neil Gaiman', 'American Gods', '2001-06-19', 470, 'No', 'A fantasy novel exploring the conflict between the old gods of mythology...', '2024-10-08 14:30:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (12, 'Yuval Noah Harari', 'A Brief History of Humankind', '2011-09-04', 530, 'No', 'A popular science book that chronicles the history of humankind...', '2024-10-09 10:00:00', '2024-10-13 11:00:00');

-- Вставка без Ticket
Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) 
values ('F. Scott Fitzgerald', 'The Great Gatsby', '1925-04-10', 290, 'No', 'A novel set in the Jazz Age...');

-- Вставка з обома датами
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (5, 'Dmytro Oleksiiovych Hlukhovskyi', 'METRO 2033', '2005-08-14', 381, 'No', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia', '2024-5-01 10:21:00', '2024-10-05 18:49:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (7, 'Andrzej Sapkowski', 'The Witcher', '1990-07-21', 460, 'No', 'The books have been described as having a cult following...', '2024-10-02 13:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (9, 'J. M. Barlog', 'God of War', '2018-06-05', 583, 'Yes', 'His vengeance against the Gods of Olympus...', '2024-10-03 15:00:00', '2024-10-07 10:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (13, 'Ernest Cline', 'Ready Player One', '2011-08-16', 490, 'Yes', 'A science fiction novel set in a dystopian future...', '2024-10-05 09:00:00');

-- Вставка з обома датами
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (3, 'J.R.R. Tolkien', 'The Hobbit', '1937-09-21', 410, 'No', 'A fantasy novel that serves as a prelude to The Lord of the Rings...', '2024-10-04 09:30:00', '2024-10-08 12:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (9, 'Stephen King', 'The Shining', '1977-01-28', 450, 'No', 'A horror novel about a family isolated in an eerie...', '2024-10-05 16:00:00', '2024-10-09 14:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (4, 'Margaret Atwood', 'The Handmaid''s Tale', '1985-04-01', 350, 'No', 'A dystopian novel set in a theocratic society...', '2024-10-06 10:30:00', '2024-10-10 13:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (12, 'Dan Brown', 'The Da Vinci Code', '2003-03-18', 520, 'No', 'A mystery thriller novel...', '2024-10-07 12:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (10, 'Neil Gaiman', 'American Gods', '2001-06-19', 470, 'No', 'A fantasy novel exploring the conflict between the old gods...', '2024-10-08 14:30:00', '2024-10-12 12:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (1, 'Yuval Noah Harari', 'A Brief History of Humankind', '2011-09-04', 530, 'No', 'A popular science book that chronicles the history of humankind...', '2024-10-09 10:00:00', '2024-12-09 13:57:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (2, 'J.R.R. Tolkien', 'The Hobbit', '1937-09-21', 410, 'No', 'A fantasy novel about Bilbo Baggins', '2024-10-09 11:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (3, 'George Orwell', '1984', '1949-06-08', 320, 'No', 'A dystopian novel warning of totalitarianism', '2024-7-10 09:30:00', '2024-12-11 11:03:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (4, 'J.K. Rowling', 'Harry Potter Sorcerers Stone', '1997-06-26', 450, 'No', 'A young wizard begins his journey', '2024-05-02 14:45:00', '2024-07-03 15:24:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (5, 'F. Scott Fitzgerald', 'The Great Gatsby', '1925-04-10', 290, 'No', 'A novel exploring wealth and the American dream', '2024-10-11 10:15:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (6, 'Margaret Atwood', 'The Handmaids Tale', '1985-04-01', 350, 'No', 'A dystopian novel about womens rights','2024-10-11 10:17:00', '2024-10-11 16:30:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (7, 'Stephen King', 'The Shining', '1977-01-28', 450, 'No', 'A horror novel about a haunted hotel', '2024-10-12 08:50:00', '2024-12-31 08:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (8, 'Dan Brown', 'The Da Vinci Code', '2003-03-18', 520, 'No', 'A mystery thriller about secret codes', '2024-10-12 13:40:00', '2024-10-15 15:24:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (9, 'J.M. Barlog', 'God of War', '2018-06-05', 583, 'Yes', 'A man battles gods in Norse mythology', '2024-10-13 09:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (10, 'Andrzej Sapkowski', 'The Witcher', '1990-07-21', 460, 'No', 'A cult fantasy series about a monster hunter', '2024-10-13 14:10:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (11, 'Harper Lee', 'To Kill a Mockingbird', '1960-07-11', 300, 'No', 'A novel about race and morality in the American South', '2024-03-10 16:40:00', '2024-10-14 10:20:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (12, 'Neil Gaiman', 'American Gods', '2001-06-19', 470, 'No', 'A novel exploring mythology in modern America', '2024-09-06 12:37:00', '2024-10-14 15:30:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (13, 'Ernest Cline', 'Ready Player One', '2011-08-16', 490, 'Yes', 'A dystopian novel set in a virtual reality world', '2024-10-15 09:45:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (4, 'Leo Tolstoy', 'War and Peace', '1869-03-04', 600, 'No', 'A historical novel about Russian society', '2024-01-01 08:00:00', '2024-10-15 14:50:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (5, 'Fyodor Dostoevsky', 'Crime and Punishment', '1866-01-01', 480, 'No', 'A philosophical novel about morality', '2023-10-16 11:20:00', '2024-10-16 11:20:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (6, 'Jules Verne', 'Twenty Thousand Leagues Under Sea', '1870-03-20', 350, 'No', 'A classic science fiction adventure novel', '2023-10-16 15:10:00', '2024-12-06 12:34:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (7, 'Isaac Asimov', 'Foundation', '1951-08-21', 390, 'No', 'A science fiction novel about the fall of an empire', '2023-12-17 17:59:00', '2024-10-31 10:00:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (8, 'Ray Bradbury', 'Fahrenheit 451', '1953-10-19', 320, 'No', 'A dystopian novel about censorship', '2024-10-17 14:30:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate, DateOfReceipt) 
values (9, 'Frank Herbert', 'Dune', '1965-08-01', 450, 'No', 'A science fiction epic set on a desert planet', '2023-10-18 09:15:00', '2024-05-27 09:55:00');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout, IssueDate) 
values (1, 'H.G. Wells', 'The War of the Worlds', '1898-04-01', 300, 'No', 'A novel about an alien invasion of Earth', '2024-10-18 13:40:00');




select * from Books;
select * from Readers;



SELECT Name, Author, Date, IssueDate, DateOfReceipt
	FROM Books 
	WHERE Books.Ticket=1;

SELECT PIB, IssueDate, DateOfReceipt
	FROM Books INNER JOIN Readers
	ON Books.Ticket=Readers.Ticket
	WHERE Name='METRO 2033'
	GROUP BY PIB, IssueDate, DateOfReceipt;


SELECT PIB, IssueDate, DateOfReceipt
	FROM Books, Readers 
	WHERE Books.Ticket=Readers.Ticket
	AND IssueDate='2024-10-04 09:30:00';

SELECT TOP 1 Author, Name, COUNT(Ticket) Demand
	FROM Books
	WHERE Ticket IS NOT NULL
	GROUP BY Author, Name
	ORDER BY Demand DESC;





