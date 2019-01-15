DROP SCHEMA IF EXSIST mediatek;
CREATE SCHEMA mediatek;
USE mediatek;

DROP TABLE IF EXSIST Bok;
DROP TABLE IF EXSIST Film;
DROP TABLE IF EXSIST Magasin;
DROP TABLE IF EXSIST Fag;
DROP TABLE IF EXSIST Semestertabell;
DROP TABLE IF EXSIST LestBok;
DROP TABLE IF EXSIST Skolebok_HSN;
DROP TABLE IF EXSIST Karakterlogg;
DROP TABLE IF EXSIST Handleliste;

CREATE TABLE Bok (
ISBN CHAR (13),
Tittel VARCHAR (50),
Opplag CHAR (2),
Forfatter VARCHAR (70),
Forlag VARCHAR (70),
AntallSider CHAR (4),
Omslag VARCHAR (10),
Sjanger VARCHAR (30),
CONSTRAINT BokPK PRIMARY KEY (ISBN)
);

CREATE TABLE Film (
Tittel VARCHAR (50),
Aldersgrense CHAR (2),
Sjanger VARCHAR (30),
Medium VARCHAR (15),
CONSTRAINT FilmPK PRIMARY KEY (Tittel)
);

CREATE TABLE Magasin (
ISBN CHAR (13),
Tittel VARCHAR (50),
Nr CHAR (2),
Årgang YEAR,
CONSTRAINT MagasinPK PRIMARY KEY (ISBN, Nr, Årgang)
);

CREATE TABLE Fag (
Fagkode CHAR(8),
Fagnavn CHAR(50),
Karakter CHAR(1),
Studiepoeng DECIMAL(3,1),
CONSTRAINT FagPK PRIMARY KEY (Fagkode)
);

CREATE TABLE Semestertabell (
Semester CHAR(1),
År CHAR(5),
CONSTRAINT SemestertabellPK PRIMARY KEY (Semester)
);

CREATE TABLE LestBok (
ISBN CHAR(13),
Påbegynt DATE,
Ferdig DATE,
CONSTRAINT LestBokPK PRIMARY KEY (ISBN, Påbegynt),
CONSTRAINT LestBokBokFK FOREIGN KEY (ISBN) REFERENCES Bok(ISBN)
);

CREATE TABLE Skolebok_HSN (
ISBN CHAR(13),
Fagkode CHAR(8),
Semester CHAR(1),
CONSTRAINT SkolebokPK PRIMARY KEY (ISBN, Fagkode),
CONSTRAINT SkolebokBokFK FOREIGN KEY (ISBN) REFERENCES Bok(ISBN),
CONSTRAINT SkolebokFagFK FOREIGN KEY (Fagkode) REFERENCES Fag(Fagkode),
CONSTRAINT SkolebokSemestertabellFK FOREIGN KEY (Semester) REFERENCES Semestertabell(Semester)
);

CREATE TABLE Karakterlogg (
Dato TIMESTAMP,
Fagkode CHAR(8),
OldKarakter CHAR(1),
NewKarakter CHAR(1),
CONSTRAINT KarakterloggPK PRIMARY KEY (Dato, Fagkode),
CONSTRAINT KarakterloggFagFK FOREIGN KEY (Fagkode) REFERENCES Fag(Fagkode)
);

-- Forslag til ny tabeller til mediateket

CREATE TABLE Handleliste (
Tittel VARCHAR(100),
Av VARCHAR(100),
Typen VARCHAR(15)
Handlet TINYINT
CONTRAINT HandlelistePK PRIMARY KEY (Tittel, Typen)
);
