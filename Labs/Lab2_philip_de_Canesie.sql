ALTER TABLE Böcker
ADD CONSTRAINT FK_Böker_FörfattareID
FOREIGN KEY (FörfattareID)
REFERENCES Författare (Id)

ALTER TABLE LagerSaldo
ADD CONSTRAINT FK_LagerSaldo_ButikID
FOREIGN KEY (ButikID)
REFERENCES Butiker (Id)

ALTER TABLE LagerSaldo
ADD CONSTRAINT FK_LagerSaldo_ISBN
FOREIGN KEY (ISBN)
REFERENCES Böcker (ISBN13)

ALTER TABLE Ordrar_detaljer
ADD CONSTRAINT FK_Ordrar_detaljer_OrderId
FOREIGN KEY (OrderId)
REFERENCES Ordrar (Id)

ALTER TABLE Ordrar_detaljer
ADD CONSTRAINT FK_Ordrar_detaljer_BokId
FOREIGN KEY (BokId)
REFERENCES Böcker (ISBN13)

ALTER TABLE Ordrar
ADD CONSTRAINT FK_Ordrar_KundId
FOREIGN KEY (KundId)
REFERENCES Kunder (Id)

ALTER TABLE Ordrar
ADD CONSTRAINT FK_Ordrar_ButikId
FOREIGN KEY (ButikId)
REFERENCES Butiker (Id)

-- lägger till som demo data.
SET IDENTITY_INSERT Böcker ON

-- Lord of the rings 

INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) 
VALUES('J.R.R.', 'Tolkien', '1892-01-03')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780261102354, 'The Fellowship of the Ring', 'Engelska', 149, '1991-07-04', 0)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780261102361, 'The Two Towers', 'Engelska', 133, '2007-04-01', 0)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780261102378, 'The Return of the King', 'Engelska', 121, '2007-04-01', 0)

-- Stormlight Archive

INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) 
VALUES('Brandon', 'Sanderson', '1975-12-19')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780765365279, 'The Way of Kings', 'Engelska', 146, '2011-05-01', 1)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780765326362, 'Words of Radiance', 'Engelska', 264, '2014-03-01', 1)

-- The Hitchhikers Guide to the Galaxy

INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) 
VALUES('Douglas', 'Adams', '1952-3-11')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780345391803, 'The Hitchhikers Guide to the Galaxy', 'Engelska', 113, '1995-09-01', 2)

-- Sun Eater

INSERT INTO Författare (Förnamn, Efternamn) 
VALUES('Christopher', 'Ruocchio')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781473218277, 'Empire of Silence', 'Engelska', 168, '2019-03-21', 3)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781473218307, 'Howling Dark', 'Engelska', 170, '2020-01-09', 3)

-- the expanse

INSERT INTO Författare (Förnamn, Efternamn) 
VALUES('James S. A.', 'Corey')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781841499895, 'Leviathan Wakes', 'Engelska', 132, '2012-05-03', 4)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781841499918, 'Calibans War', 'Engelska', 143, '2013-05-02', 4)


-- Butiker 

INSERT INTO Butiker ([address], Stad, Land, Postnummer, butiksnamn) 
VALUES('Kungsgatan 34', 'Göteborg', 'Sverige', 41119, 'Adlibris')

INSERT INTO Butiker ([address], Stad, Land, Postnummer, butiksnamn) 
VALUES('Kungsgatan 15', 'Stockholm', 'Sverige', 11135, 'Adlibris')

INSERT INTO Butiker ([address], Stad, Land, Postnummer, butiksnamn) 
VALUES('Älvebacken 13', 'Kungälv', 'Sverige', 44248, 'Akademibokhandeln')

-- LagerSaldo 

INSERT INTO LagerSaldo (ISBN, Antal, ButikID) 
VALUES(9780765365279, 10, 0)

INSERT INTO LagerSaldo (ISBN, Antal, ButikID) 
VALUES(9780765326362, 11, 0)

INSERT INTO LagerSaldo (ISBN, Antal, ButikID) 
VALUES(9781841499918, 13, 2)

-- Kunder

INSERT INTO Kunder (Förnamn, Efternamn, [address], Stad, Land, Postnummer, mobilnummer, Email) 
VALUES('Peter', 'Andersson', 'blåbärsvägen 13', 'Göteborg', 'Sverige', 44321, 0723212344, 'peter.andersson@gmail.com')

INSERT INTO Kunder (Förnamn, Efternamn, [address], Stad, Land, Postnummer, mobilnummer, Email) 
VALUES('Alva', 'Skog', 'Smultronstigen 2', 'Stockholm', 'Sverige', 11165, 0742442345, 'Alva.skog@gmail.com')

INSERT INTO Kunder (Förnamn, Efternamn, [address], Stad, Land, Postnummer, mobilnummer, Email) 
VALUES('Adam', 'Johansson', 'Skogsvägen 22', 'Göteborg', 'Sverige', 44461, 0733452664, 'adam.johansson@gmail.com')

-- Ordrar

INSERT INTO Ordrar (KundId, ButikId, OrderDate)
VALUES (2, 1, '2023-01-01')

INSERT INTO Ordrar (KundId, ButikId, OrderDate)
VALUES (2, 1, '2023-03-04')

INSERT INTO Ordrar (KundId, ButikId, OrderDate)
VALUES (2, 2, '2023-04-20')

-- Ordrar_detaljer

INSERT INTO Ordrar_detaljer (OrderId, BokId, Mängd)
VALUES (8, 9780345391803, 1)

-- Vy

/* CREATE VIEW TitlarPerFörfattare AS
SELECT 
    CONCAT(Förnamn, ' ', Efternamn) as Name,
    CONCAT(ISNULL(CAST(DATEDIFF(YEAR, Födelsedatum, GETDATE()) as nvarchar), '-'), ' år') as Ålder,
    CONCAT(COUNT(DISTINCT b.ISBN13), ' st') as Titlar,
    CONCAT(SUM(b.Pris * l.Antal), ' kr') as Lagervärde
FROM 
    Författare f 
JOIN 
    Böcker b on b.FörfattareID = f.Id 
JOIN 
    LagerSaldo l on l.ISBN = b.ISBN13 
GROUP BY 
    f.id, 
    f.Förnamn, 
    f.Efternamn, 
    f.Födelsedatum; */

SELECT TOP 1 * FROM TitlarPerFörfattare;
 