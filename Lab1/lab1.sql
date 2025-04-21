USE library;

DROP TABLE IF EXISTS ReadersTakingBook;

--ALTER TABLE ReadersTakingBook
--	DROP CONSTRAINT IF EXISTS BooksForeign;

--ALTER TABLE ReadersTakingBook
--	DROP CONSTRAINT IF EXISTS ReadersForeign;

--ALTER TABLE Books
--	DROP CONSTRAINT IF EXISTS BooksReadersFoKey;

--ALTER TABLE Books
--	DROP CONSTRAINT IF EXISTS BooksPrimary;

ALTER TABLE Readers
	DROP CONSTRAINT IF EXISTS ReadersPrimary;

drop table Readers;
drop table Books;


CREATE TABLE Readers
	(Ticket INT IDENTITY,
	PIB VARCHAR(35),
	Contacts VARCHAR(35),
--	CONSTRAINT ReadersPrimary PRIMARY KEY (Ticket)
	);

CREATE TABLE Books
	(Author VARCHAR(35) NOT NULL,
	Name VARCHAR(35) NOT NULL,
	Date smalldatetime NOT NULL,
	Price INT NOT NULL,
	IfNew VARCHAR(3) NOT NULL,
	WhatAbout VARCHAR(1000) NOT NULL,
--	Ticket INT NOT NULL DEFAULT 0,
	CONSTRAINT BooksPrimary  PRIMARY KEY (Author, Name,  Date),
--	CONSTRAINT BooksReadersFoKey FOREIGN KEY (Ticket) REFERENCES Readers
	);

Insert Readers (PIB, Contacts) values ('Bychok Vadym Viacheslavovych', '+380977577586 bichok.vv@gmail.com');
Insert Readers (PIB, Contacts) values ('Pylypchuk Nazar Sergiyovich', '+38068186098 pylypserg@gmail.com');
Insert Readers (PIB, Contacts) values ('Lushuck Denis Yuriyovich', '+38055540464 lisik@gmail.com');

Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) values ('Dmytro Oleksiiovych Hlukhovskyi', 'METRO 2033', '08.14.2005', 381, 'No', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia');
Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) values ('Andrzej Sapkowski', 'The Witcher', '07.21.1990', 460, 'No', 'The books have been described as having a cult following in Poland and throughout Central and Eastern Europe. They have been translated into 37 languages and sold over 15 million copies worldwide as of July 2020. They have also been adapted into a film (The Hexer), two television series (The Hexer and The Witcher), a video game series, and a series of comic books. The video games have been even more successful, with more than 75 million copies sold as of May 2023.');
Insert Books (Author, Name, Date, Price, IfNew, WhatAbout) values ('J. M. Barlog', 'God of War', '06.05.2018', 583, 'Yes', 'His vengeance against the Gods of Olympus years behind him, Kratos now lives as a man in the realm of Norse gods and monsters. It is in this harsh, unforgiving world that he must fight to survive… and teach his son to do the same. This startling reimagining of God of War deconstructs the core elements that defined the series—satisfying combat; breathtaking scale; and a powerful narrative—and fuses them anew.');




select * from Books;
select * from Readers;