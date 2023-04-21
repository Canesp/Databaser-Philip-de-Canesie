/* a)   Ta ut (select) en rad för varje (unik) period i tabellen ”Elements” med
        följande kolumner: ”period”, ”from” med lägsta atomnumret i perioden,
        ”to” med högsta atomnumret i perioden, ”average isotopes” med
        genomsnittligt antal isotoper visat med 2 decimaler, ”symbols” med en
        kommaseparerad lista av alla ämnen i perioden.  */

SELECT DISTINCT [Period], MIN(Number) as 'from', MAX(Number) as 'to', ROUND(AVG(Stableisotopes), 2) as 'average isotopes', STRING_AGG(Symbol, ', ') as symbols FROM Elements GROUP BY [Period];

/* b)   För varje stad som har 2 eller fler kunder i tabellen Customers, ta ut
        (select) följande kolumner: ”Region”, ”Country”, ”City”, samt
        ”Customers” som anger hur många kunder som finns i staden.  */

SELECT Region, Country, City, COUNT(*) as 'Customers' FROM company.customers GROUP BY Region, Country, City HAVING COUNT(City) >= 2; 

/* c)   Skapa en varchar-variabel och skriv en select-sats som sätter värdet:
        ”Säsong 1 sändes från april till juni 2011. Totalt
        sändes 10 avsnitt, som i genomsnitt sågs av 2.5
        miljoner människor i USA.”, följt av radbyte/char(13), följt av
        ”Säsong 2 sändes …” osv.
        När du sedan skriver (print) variabeln till messages ska du alltså få en rad
        för varje säsong enligt ovan, med data sammanställt från tabellen
        GameOfThrones.
        Tips: Ange ’sv’ som tredje parameter i format() för svenska månader. */


SELECT * FROM GameOfThrones;

SET LANGUAGE Swedish;

DECLARE @air as VARCHAR;

set @air = (SELECT CONCAT('Säsong ', Season, ' sändes från ', DATENAME(month, MIN([Original air date])), 'till ', DATENAME(month, MAX([Original air date])), ' ', YEAR(MIN([Original air date])), '. Totalt
    sändes ', SUM(EpisodeInSeason), ' avsnitt, som i genomsnitt sågs av ', AVG([U.S. viewers(millions)]), ' miljoner människor i USA.', CHAR(13)) FROM GameOfThrones GROUP BY Season);

PRINT(@air)