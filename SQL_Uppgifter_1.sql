-- Creates a copy of GameOfThrones table.
SELECT * INTO Uppgift1 FROM GameOfThrones;

/* a)   Ta ut data (select) från tabellen GameOfThrones på sådant sätt att ni får ut
        en kolumn ’Title’ med titeln samt en kolumn ’Episode’ som visar episoder
        och säsonger i formatet ”S01E01”, ”S01E02”, osv.
        Tips: kolla upp funktionen format() */ 

SELECT Title, CONCAT('S', RIGHT(CONCAT('00', Season), 2), 'E', RIGHT(CONCAT('00', EpisodeInSeason), 2)) as Episode FROM Uppgift1;

/* b)   Uppdatera (kopia på) tabellen user och sätt username för alla användare så
        den blir de 2 första bokstäverna i förnamnet, och de 2 första i efternamnet
        (istället för 3+3 som det är i orginalet). Hela användarnamnet ska vara i små
        bokstäver.  */

-- Creates a copy of Users tabel.
SELECT * INTO Uppgift1_user FROM Users;

UPDATE Uppgift1_user SET UserName = LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2)));

/* c)   Uppdatera (kopia på) tabellen airports så att alla null-värden i kolumnerna
        Time och DST byts ut mot ’-’  */

-- Creates a copy of Airports tabel.
SELECT * INTO Uppgift1_airports FROM Airports;

UPDATE Uppgift1_airports SET [Time] = ISNULL([Time], '-'), DST = ISNULL(DST, '-');

/* d)   Ta bort de rader från (kopia på) tabellen Elements där ”Name” är någon av
        följande: 'Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium', samt alla
        rader där ”Name” börjar på någon av bokstäverna d, k, m, o, eller u.  */

-- Creates a copy of Elements tabel.
SELECT * INTO Uppgift1_elements FROM Elements;

DELETE FROM Uppgift1_elements WHERE [Name] IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium') OR [Name] LIKE '[dkmou]%';

/* e)   Skapa en ny tabell med alla rader från tabellen Elements. Den nya tabellen
        ska innehålla ”Symbol” och ”Name” från orginalet, samt en tredje kolumn
        med värdet ’Yes’ för de rader där ”Name” börjar med bokstäverna i
        ”Symbol”, och ’No’ för de rader där de inte gör det.
        Ex: ’He’ -> ’Helium’ -> ’Yes’, ’Mg’ -> ’Magnesium’ -> ’No’.  */

-- Creates a copy of Elements tabel.
SELECT Symbol, [Name] INTO Uppgift1_elements2 FROM Elements;

ALTER TABLE Uppgift1_elements2 ADD Yes CHAR(3);

UPDATE Uppgift1_elements2 SET Yes = CASE WHEN SUBSTRING(Symbol, 1, LEN(Symbol)) = SUBSTRING([Name], 1, LEN(Symbol)) THEN 'Yes' ELSE 'No' END;

/* f)   Kopiera tabellen Colors till Colors2, men skippa kolumnen ”Code”. Gör
        sedan en select från Colors2 som ger samma resultat som du skulle fått från
        select * from Colors; (Dvs, återskapa den saknade kolumnen från RGBvärdena i resultatet).  */

-- Creates a copy of Colors tabel.
SELECT [Name], Red, Green, Blue INTO Uppgift1_Colors2 FROM Colors;

SELECT * FROM Uppgift1_Colors2;

DECLARE @hex_table varchar(16) = '0123456789abcdef';

SELECT [Name], Code ='#' + UPPER(SUBSTRING(@hex_table, (Red / 16) + 1, 1) + SUBSTRING(@hex_table, (Red % 16) + 1, 1) +
       SUBSTRING(@hex_table, (Green / 16) + 1, 1) + SUBSTRING(@hex_table, (Green % 16) + 1, 1) +
       SUBSTRING(@hex_table, (Blue / 16) + 1, 1) + SUBSTRING(@hex_table, (Blue % 16) + 1, 1)), Red, Green, Blue FROM Uppgift1_Colors2;

/* g)   Kopiera kolumnerna ”Integer” och ”String” från tabellen ”Types” till en ny
        tabell. Gör sedan en select från den nya tabellen som ger samma resultat
        som du skulle fått från select * from types; */ 

-- Creates a copy of Types tabel.
SELECT [Integer], String INTO Uppgift1_Types FROM Types;

SELECT [Integer], [FLOAT] = CAST([Integer] AS FLOAT) / CAST(100 AS FLOAT), String, DateTime = '2019-01-' + RIGHT(CONCAT('00', [Integer]), 2) + ' 09:' + RIGHT(CONCAT('00', [Integer]), 2) + ':00.0000000', Bool = CASE WHEN [Integer] % 2 = 0 THEN 0 ELSE 1 END FROM Uppgift1_Types;

SELECT * FROM Types;
