SELECT COUNT(DISTINCT [PERIOD])
FROM Elements;

SELECT COUNT(*), COUNT(Meltingpoint), COUNT(Boilingpoint), COUNT(*) - COUNT(Meltingpoint) as 'Null Values in meltingpoint'
, SUM(Mass) as 'Sum of mass', AVG(Boilingpoint) as 'Avg boilingpoint', MIN(boilingpoint) as 'Min boilingpoint', MAX(boilingpoint) as 'Max boilingpoint',
    STRING_AGG(symbol, ', ')
FROM Elements;

SELECT [period], COUNT(period), STRING_AGG(symbol, ', ')
FROM Elements
WHERE Boilingpoint < 500
GROUP BY [period]
HAVING COUNT(period) >= 18;

SELECT id, ShipRegion, shipcountry, shipcity
FROM company.orders
ORDER BY ShipRegion, shipcountry, shipcity;

SELECT ShipRegion, shipcountry, shipcity, COUNT(*) as 'Number of orders'
FROM company.orders
GROUP BY ShipRegion, shipcountry, shipcity;

SELECT NEWID()

SELECT CAST('45' as int)
SELECT CONVERT(int, '45')

declare @username as nvarchar(max) = 'sigpet';
declare @email as nvarchar(max);

set @email = (select top 1 firstname from users where UserName = @username);

print concat('Email for user ', @username, ' is ', @email)


