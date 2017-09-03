-- Viser sammenlagt studiepoeng / totalt antall studiepoeng
DROP VIEW IF EXISTS Studiepoeng_totalt;
CREATE VIEW Studiepoeng_totalt AS
SELECT SUM(Studiepoeng) AS StudiepoengTotalt
FROM Fag
WHERE Karakter IS NOT NULL;


-- Viser boktittel, fagnavn, karakter, semster(1.-6.) og halvår (H2016-V2019)
DROP VIEW IF EXISTS Semesteroversikt;
CREATE VIEW Semesteroversikt AS
SELECT Bok.Tittel, Fag.Fagnavn, Fag.Karakter,  Semestertabell.Semester, Semestertabell.År
FROM Bok
  JOIN (Fag
    JOIN (Skolebok_HSN
      JOIN Semestertabell
      USING(Semester))
    USING(Fagkode))
  USING(ISBN)
ORDER BY Semester, Fagnavn;


-- Karakterutskrift
DROP VIEW IF EXISTS Karakterutskrift;
CREATE VIEW Karakterutskrift AS
SELECT DISTINCT Fagnavn, Karakter, Semestertabell.Semester
FROM Fag
  JOIN (Skolebok_HSN
    JOIN Semestertabell
    USING(Semester))
  USING(Fagkode)
WHERE Karakter IS NOT NULL;


DROP VIEW IF EXISTS Karakterutskrift_antall;
CREATE VIEW Karakterutskrift_antall AS
SELECT Karakter, COUNT(Karakter) AS Antall, Semester, År
FROM Karakterutskrift JOIN Semestertabell
  USING(Semester)
GROUP BY Karakter, Semester, År
ORDER BY Semester, Karakter;


-- hugs å bruke: use information_schema;
CREATE VIEW Navn_tabeller AS
SELECT TABLE_NAME AS Tables
FROM Tables
WHERE TABLE_SCHEMA LIKE 'mediatek';


-- Dei her to (Alt_temp og Alt) visningane skal vise dei fleste kolonnene i tabellane Bok, Fag, Skolebok_HSN og Semester
-- og dermed gi ei god oversikt over kva fag har brukt kva bok og kva Karakter eg fekk i det faget, plus hvilket semester faget var i
DROP VIEW IF EXISTS Alt_temp;
CREATE VIEW Alt_temp AS
SELECT ISBN, Fagkode, Fagnavn, Semester, År, Karakter, Studiepoeng
FROM Fag
  JOIN (Skolebok_HSN
    JOIN Semestertabell
    USING(Semester))
  USING(Fagkode);

DROP VIEW IF EXISTS Alt;
CREATE VIEW Alt AS
SELECT Tittel, Alt_temp.*
FROM Bok JOIN Alt_temp USING(ISBN)
ORDER BY Semester, Fagnavn, Tittel;
