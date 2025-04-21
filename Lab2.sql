USE mssql;

ALTER TABLE Books
	DROP CONSTRAINT IF EXISTS PriceCheck;

ALTER TABLE Books
	DROP CONSTRAINT IF EXISTS BooksFoKey

ALTER TABLE Readers
	DROP CONSTRAINT IF EXISTS ReadersPrimary;

ALTER TABLE Readers
	DROP CONSTRAINT IF EXISTS ReadersPIBUnique;

ALTER TABLE Readers
	DROP CONSTRAINT IF EXISTS ReadersContactsUnique;

ALTER TABLE Readers 
	DROP COLUMN IF EXISTS Ticket;

ALTER TABLE Books
	DROP COLUMN IF EXISTS Ticket;

ALTER TABLE Readers
	DROP CONSTRAINT IF EXISTS SingDefault;

ALTER TABLE Readers
	DROP COLUMN IF EXISTS Single;



DELETE FROM Books;
DELETE FROM Readers;

ALTER TABLE Readers 
	DROP COLUMN IF EXISTS Ticket;

ALTER TABLE Readers
	ADD Ticket INT NOT NULL;

ALTER TABLE Books
	ADD Ticket INT NOT NULL;

ALTER TABLE Books
	ADD CONSTRAINT PriceCheck
	CHECK(Price>'29');

ALTER TABLE Readers
	ALTER COLUMN PIB VARCHAR(35) NOT NULL;

ALTER TABLE Readers
	ALTER COLUMN Ticket INT NOT NULL;

ALTER TABLE Readers
	ALTER COLUMN Contacts VARCHAR(35) NOT NULL;

ALTER TABLE Readers
	ADD CONSTRAINT ReadersPrimary PRIMARY KEY (Ticket);

ALTER TABLE Readers
	ADD CONSTRAINT ReadersPIBUnique UNIQUE (PIB);

ALTER TABLE Readers
	ADD CONSTRAINT ReadersContactsUnique UNIQUE (Contacts);

ALTER TABLE Books
	ADD CONSTRAINT BooksFoKey FOREIGN KEY (Ticket) REFERENCES Readers ON DELETE CASCADE;


Insert Readers (PIB, Contacts, Ticket) values ('Bychok Vadym Viacheslavovych', '+380977577586 bichok.vv@gmail.com', 1);
Insert Readers (PIB, Contacts, Ticket) values ('Pylypchuk Nazar Sergiyovich', '+38068186098 pylypserg@gmail.com', 2);
Insert Readers (PIB, Contacts, Ticket) values ('Lushuck Denis Yuriyovich', '+38055540464 lisik@gmail.com', 3);

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (1, 'Dmytro Oleksiiovych Hlukhovskyi', 'METRO 2033', '08.14.2005', 381, 'No', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (2, 'Andrzej Sapkowski', 'The Witcher', '07.21.1990', 460, 'No', 'The books have been described as having a cult following in Poland and throughout Central and Eastern Europe. They have been translated into 37 languages and sold over 15 million copies worldwide as of July 2020. They have also been adapted into a film (The Hexer), two television series (The Hexer and The Witcher), a video game series, and a series of comic books. The video games have been even more successful, with more than 75 million copies sold as of May 2023.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (3, 'J. M. Barlog', 'God of War', '06.05.2018', 583, 'Yes', 'His vengeance against the Gods of Olympus years behind him, Kratos now lives as a man in the realm of Norse gods and monsters. It is in this harsh, unforgiving world that he must fight to survive… and teach his son to do the same. This startling reimagining of God of War deconstructs the core elements that defined the series—satisfying combat; breathtaking scale; and a powerful narrative—and fuses them anew.');


--DELETE FROM Readers
--	WHERE Ticket = 2;


ALTER TABLE Readers
	ADD Single VARCHAR(3);

ALTER TABLE Readers
	ADD CONSTRAINT SingDefault DEFAULT 'Yes' FOR Single;

ALTER TABLE Books
	DROP CONSTRAINT IF EXISTS BooksFoKey;

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (4, 'Ddmytro Oleksiiovych Hlukhovskyi', 'MEtTRO 2033', '09.14.2005', 382, 'Yes', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia');

Insert Readers (PIB, Contacts, Ticket) values ('Vychok Badymyr Ciacheslavovych', '+380977777586 bychok.vv@gmail.com', 4);

ALTER TABLE Books
	ADD CONSTRAINT BooksFoKey FOREIGN KEY (Ticket) REFERENCES Readers ON DELETE CASCADE;

EXEC SP_RENAME 'Readers', 'READERS1';

EXEC SP_RENAME 'READERS1', 'Readers';

select * from Books;
select * from Readers;