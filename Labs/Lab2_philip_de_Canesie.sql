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

ALTER TABLE Böcker
ADD CONSTRAINT FK_Böcker_FörlagId
FOREIGN KEY (FörlagId)
REFERENCES Förlag (Id)

ALTER TABLE BöckerFörfattre
ADD CONSTRAINT FK_BöckerFörfattare_ISBN
FOREIGN KEY (ISBN)
REFERENCES Böcker (ISBN13)

ALTER TABLE BöckerFörfattre
ADD CONSTRAINT FK_BöckerFörfattare_FörfattareId
FOREIGN KEY (FörfattareId)
REFERENCES Författare (Id)

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

INSERT INTO Förlag (Namn, kontaktperson, Email)
VALUES('harperCollins UK', 'Maria Bengtsson', 'harperCollinsUK@gmail.com')

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9780261102354, 0)

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9780261102361, 0)

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9780261102378, 0)

-- Stormlight Archive

INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) 
VALUES('Brandon', 'Sanderson', '1975-12-19')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780765365279, 'The Way of Kings', 'Engelska', 146, '2011-05-01', 1)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780765326362, 'Words of Radiance', 'Engelska', 264, '2014-03-01', 1)

INSERT INTO Förlag (Namn, kontaktperson, Email)
VALUES('Tor Books', 'Stefan skog', 'TorBooks@gmail.com')

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9780765365279, 1)

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9780765326362, 1)

-- The Hitchhikers Guide to the Galaxy

INSERT INTO Författare (Förnamn, Efternamn, Födelsedatum) 
VALUES('Douglas', 'Adams', '1952-3-11')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9780345391803, 'The Hitchhikers Guide to the Galaxy', 'Engelska', 113, '1995-09-01', 2)

INSERT INTO Förlag (Namn, kontaktperson, Email)
VALUES('Del Rey Books', 'Joel Andersson', 'DelReyBooks@gmail.com')

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9780345391803, 2)

-- Sun Eater

INSERT INTO Författare (Förnamn, Efternamn) 
VALUES('Christopher', 'Ruocchio')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781473218277, 'Empire of Silence', 'Engelska', 168, '2019-03-21', 3)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781473218307, 'Howling Dark', 'Engelska', 170, '2020-01-09', 3)

INSERT INTO Förlag (Namn, kontaktperson, Email)
VALUES('Gollancz', 'Karl Andersson', 'Gollancz@gmail.com')

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9781473218277, 3)

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9781473218307, 3)

-- the expanse

INSERT INTO Författare (Förnamn, Efternamn) 
VALUES('James C. A.', 'Corey')

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781841499895, 'Leviathan Wakes', 'Engelska', 132, '2012-05-03', 5)

INSERT INTO Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID) 
VALUES(9781841499918, 'Calibans War', 'Engelska', 143, '2013-05-02', 4)

INSERT INTO Förlag (Namn, kontaktperson, Email)
VALUES('Little Brown', 'Adam tor', 'LittleBrown@gmail.com')

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9781841499895, 4)

INSERT INTO BöckerFörfattre (ISBN, FörfattareId)
VALUES(9781841499918, 4)


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
    BöckerFörfattre bf on bf.FörfattareId = f.Id
JOIN 
    Böcker b on b.ISBN13 = bf.ISBN
JOIN 
    LagerSaldo l on l.ISBN = b.ISBN13 
GROUP BY 
    f.id, 
    f.Förnamn, 
    f.Efternamn, 
    f.Födelsedatum; */

SELECT * FROM TitlarPerFörfattare;

-- PROCEDURE

ALTER PROCEDURE FlyttaBok @från INT, @till INT, @ISBN BIGINT, @Antal INT = 1 AS
BEGIN
    DECLARE @valuescorrect as BIT = (0);

    IF @från IN (SELECT Id FROM Butiker)
    BEGIN
        SET @valuescorrect = 1;
    END;
    ELSE
    BEGIN;
        PRINT('ButikId (från) finns inte!');
        SET @valuescorrect = 0;
    END;

    IF @till IN (SELECT Id FROM Butiker)
    BEGIN
        SET @valuescorrect = 1;
    END;
    ELSE
    BEGIN
        PRINT('ButikId (till) finns inte!');
        SET @valuescorrect = 0;
    END;

    IF @ISBN IN (SELECT ISBN FROM LagerSaldo WHERE ButikID = @från)
    BEGIN

        IF (SELECT Antal FROM LagerSaldo WHERE ISBN = @ISBN AND ButikID = @från) >= @antal
        BEGIN
            SET @valuescorrect = 1;
        END;
        ELSE
        BEGIN
            PRINT('Det finns inte tillräckligt många böcker!');
            SET @valuescorrect = 0;
        END;

    END;
    ELSE
    BEGIN
        PRINT('ISBN finns inte!');
        SET @valuescorrect = 0;
    END; 

    IF @valuescorrect = 1 AND @antal > 0
    BEGIN

        IF @ISBN IN (SELECT ISBN FROM LagerSaldo WHERE ButikID = @till)
        BEGIN
            UPDATE 
                LagerSaldo
            SET 
                Antal += @Antal
            WHERE
                ButikID = @till;

            UPDATE 
                LagerSaldo
            SET 
                Antal -= @Antal
            WHERE
                ButikID = @från;
        END;
        ELSE
        BEGIN
            INSERT INTO LagerSaldo (ISBN, Antal, ButikID)
            VALUES(@ISBN, @Antal, @till);

             UPDATE 
                LagerSaldo
            SET 
                Antal -= @Antal
            WHERE
                ButikID = @från;
        END;
    END;
    
    ELSE
    BEGIN
        PRINT('ERROR KAN INTE UTFÖRA FÖRFLYTTNING DÅ ALLA KRAV INTE VAR UPPFYLLDA.');
    END

END;

EXECUTE FlyttaBok 2, 0, 9780261102361, 1;




