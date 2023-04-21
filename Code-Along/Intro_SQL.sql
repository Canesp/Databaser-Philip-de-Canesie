SELECT *
From Users;

SELECT FirstName, LastName
FROM Users;

SELECT TOP 10
    LastName, FirstName, LastName, upper('Hejsan ') + FirstName + ' ' + LastName as 'Greeting'
FROM Users
WHERE LEN(FirstName) = 4;

SELECT *
FROM Airports
WHERE IATA BETWEEN 'AAA' and 'ADH';

SELECT *
FROM Airports
WHERE IATA LIKE 'G%';

SELECT *
FROM Users
ORDER BY LastName, FirstName DESC;

SELECT DISTINCT Season
FROM GameOfThrones;

SELECT *
from GameOfThrones;

SELECT DISTINCT Season, [U.S. viewers(millions)]
from GameOfThrones;

    SELECT FirstName as 'Förnamn', LastName as 'Efternamn'
    FROM Users
UNION ALL
    SELECT Title, [Directed by]
    FROM GameOfThrones;

SELECT *, CASE WHEN LEN(FirstName) <= 4 THEN 'Kort' WHEN LEN(FirstName) >= 9 THEN 'Långt' ELSE 'Mellan' END AS 'Längd på förnamn'
FROM Users;