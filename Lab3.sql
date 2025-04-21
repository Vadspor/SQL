USE mssql;

DELETE FROM Books;
DELETE FROM Readers;

Insert Readers (PIB, Contacts, Ticket) values ('Bychok Vadym Viacheslavovych', '+380977577586 bichok.vv@gmail.com', 1);
Insert Readers (PIB, Contacts, Ticket) values ('Pylypchuk Nazar Sergiyovich', '+38068186098 pylypserg@gmail.com', 2);
Insert Readers (PIB, Contacts, Ticket) values ('Lushuck Denis Yuriyovich', '+38055540464 lisik@gmail.com', 3);

Insert Readers (PIB, Contacts, Ticket) values ('Vychok Badymyr Ciacheslavovych', '+380977777586 bychok.vv@gmail.com', 4);

Insert Readers (PIB, Contacts, Ticket) values ('Kravchenko Oleksandr Volodymyrovych', '+380987654321 krav.ov@gmail.com', 5);
Insert Readers (PIB, Contacts, Ticket) values ('Shevchenko Kateryna Ivanivna', '+380501234567 shev@gmail.com', 6);
Insert Readers (PIB, Contacts, Ticket) values ('Hryshchenko Yuriy Petrovych', '+380931112233 hrysh.yp@gmail.com', 7);
Insert Readers (PIB, Contacts, Ticket) values ('Ivanenko Svitlana Olegivna', '+380677556677 ivan.so@gmail.com', 8);
Insert Readers (PIB, Contacts, Ticket) values ('Bondarenko Oksana Mykolaivna', '+380503456789 bond@gmail.com', 9);
Insert Readers (PIB, Contacts, Ticket) values ('Koval Andriy Serhiyovych', '+380632223344 koval@gmail.com', 10);
Insert Readers (PIB, Contacts, Ticket) values ('Lytvynenko Halyna Volodymyrivna', '+380931009900 lytvyn@gmail.com', 11);
Insert Readers (PIB, Contacts, Ticket) values ('Mykhailenko Artem Ihorovych', '+380931212121 mykhail.ai@gmail.com', 12);
Insert Readers (PIB, Contacts, Ticket) values ('Stasiuk Petro Volodymyrovych', '+380977878787 stasiuk.pv@gmail.com', 13);
Insert Readers (PIB, Contacts, Ticket) values ('Vasylenko Anastasiya Viktorivna', '+380999998877 vasyl.av@gmail.com', 14);

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (1, 'Dmytro Oleksiiovych Hlukhovskyi', 'METRO 2033', '08.14.2005', 381, 'No', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (2, 'Andrzej Sapkowski', 'The Witcher', '07.21.1990', 460, 'No', 'The books have been described as having a cult following in Poland and throughout Central and Eastern Europe. They have been translated into 37 languages and sold over 15 million copies worldwide as of July 2020. They have also been adapted into a film (The Hexer), two television series (The Hexer and The Witcher), a video game series, and a series of comic books. The video games have been even more successful, with more than 75 million copies sold as of May 2023.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (3, 'J. M. Barlog', 'God of War', '06.05.2018', 583, 'Yes', 'His vengeance against the Gods of Olympus years behind him, Kratos now lives as a man in the realm of Norse gods and monsters. It is in this harsh, unforgiving world that he must fight to survive… and teach his son to do the same. This startling reimagining of God of War deconstructs the core elements that defined the series—satisfying combat; breathtaking scale; and a powerful narrative—and fuses them anew.');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (4, 'Ddmytro Oleksiiovych Hlukhovskyi', 'MEtTRO 2033', '09.14.2005', 382, 'Yes', 'Metro 2033 is a 2002 post-apocalyptic fiction novel by Russia');

Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (5, 'George Orwell', '1984', '06.08.1949', 320, 'No', 'A dystopian social science fiction novel and cautionary tale, warning of the dangers of totalitarianism and surveillance.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (6, 'J.R.R. Tolkien', 'The Hobbit', '09.21.1937', 410, 'No', 'A fantasy novel that serves as a prelude to The Lord of the Rings, telling the story of Bilbo Baggins and his journey.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (7, 'Stephen King', 'The Shining', '01.28.1977', 450, 'No', 'A horror novel about a family isolated in an eerie, haunted hotel with a terrifying past.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (8, 'Margaret Atwood', 'The Handmaid''s Tale', '04.01.1985', 350, 'No', 'A dystopian novel set in a theocratic society that treats women as property of the state.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (9, 'Harper Lee', 'To Kill a Mockingbird', '07.11.1960', 300, 'No', 'A novel set in the American South during the 1930s that deals with issues of race, class, and morality.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (10, 'Dan Brown', 'The Da Vinci Code', '03.18.2003', 520, 'No', 'A mystery thriller novel that follows a symbologist and cryptologist as they investigate a murder at the Louvre.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (11, 'Neil Gaiman', 'American Gods', '06.19.2001', 470, 'No', 'A fantasy novel exploring the conflict between the old gods of mythology and new gods reflecting modern society.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (12, 'Yuval Noah Harari', 'A Brief History of Humankind', '09.04.2011', 530, 'No', 'A popular science book that chronicles the history of humankind from the evolution of archaic human species.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (13, 'F. Scott Fitzgerald', 'The Great Gatsby', '04.10.1925', 290, 'No', 'A novel set in the Jazz Age that explores themes of wealth, excess, and the American dream.');
Insert Books (Ticket, Author, Name, Date, Price, IfNew, WhatAbout) values (14, 'Ernest Cline', 'Ready Player One', '08.16.2011', 490, 'Yes', 'A science fiction novel set in a dystopian future where people escape into a virtual reality world known as the OASIS.');


select * from Books;
select * from Readers;