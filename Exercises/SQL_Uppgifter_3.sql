/* 1. Företagets totala produktkatalog består av 77 unika produkter. Om vi kollar bland våra ordrar, hur stor andel av dessa produkter har vi någon gång leverarat till London? */

DECLARE @London_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId)
FROM company.orders o JOIN company.order_details od on o.id = od.OrderId
WHERE o.ShipCity = 'LONDON');
DECLARE @Num_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId)
FROM company.order_details od)

PRINT(@London_products / @Num_products)


/* 2. Till vilken stad har vi levererat flest unika produkter? */

SELECT TOP 1
    o.ShipCity, COUNT(DISTINCT od.ProductId) as 'Unique products'
FROM company.orders o JOIN company.order_details od on o.id = od.OrderId
GROUP BY o.ShipCity
ORDER BY 'Unique products' DESC;


/* 3. Av de produkter som inte längre finns I vårat sortiment, hur mycket har vi sålt för totalt till Tyskland? */

SELECT ROUND(SUM(od.UnitPrice * od.Quantity), 2) as 'Sold ($)'
FROM company.orders o JOIN company.order_details od on o.Id = od.OrderId JOIN company.products p on od.ProductId = p.Id
WHERE o.ShipCountry = 'Germany' AND p.Discontinued = 1;


/* 4. För vilken produktkategori har vi högst lagervärde? */

SELECT p.CategoryId, c.CategoryName, ROUND(SUM(p.UnitPrice * p.UnitsInStock), 2) as 'Value'
FROM company.categories c JOIN company.products p on c.Id = p.CategoryId
GROUP BY p.CategoryId, c.CategoryName
ORDER BY 'Value' DESC;


/* 5. Från vilken leverantör har vi sålt flest produkter totalt under sommaren 2013? */

SELECT s.Id, s.CompanyName , SUM(od.Quantity) as 'Num Products'
FROM company.orders o JOIN company.order_details od on o.Id = od.OrderId JOIN company.products p on od.ProductId = p.Id JOIN company.suppliers s on p.SupplierId = s.Id
WHERE o.OrderDate BETWEEN '2013-06-21' AND '2013-09-23'
GROUP BY s.Id, s.CompanyName
ORDER BY 'Num Products' DESC;

/* Mellan uppgift */

declare @playlist varchar(max) = 'Heavy Metal Classic';

SELECT 
    g.Name as 'Genre', 
    ar.Name as 'Artist', 
    a.Title as 'Album',
    t.Name as 'Track',
    RIGHT(CONVERT(varchar, DATEADD(MILLISECOND, t.Milliseconds, 0), 108), 5) as 'Length', 
    CONCAT(CAST(ROUND(t.Bytes / 1048576.0, 1) as numeric(36,1)), ' MiB') as 'Size',
    CASE WHEN t.Composer IS NULL THEN '-' ELSE t.Composer END as 'Composer'
FROM 
    music.playlists p 
    JOIN music.playlist_track pt on p.PlaylistId = pt.PlaylistId 
    JOIN music.tracks t on pt.TrackId = t.TrackId 
    JOIN music.genres g on t.GenreId = g.GenreId 
    JOIN music.albums a on t.AlbumId = a.AlbumId 
    JOIN music.artists ar on a.ArtistId = ar.ArtistId
WHERE p.Name = @playlist;

/* 1. Av alla audiospår, vilken artist har längst total speltid? */
/* 2. Vad är den genomsnittliga speltiden på den artistens låtar? */

SELECT 
    ar.ArtistId, 
    ar.Name, 
    SUM(t.Milliseconds) as 'total time', 
    AVG(t.Milliseconds) as 'AVG time'
FROM 
    music.tracks t 
    JOIN music.albums a on t.AlbumId = a.AlbumId 
    JOIN music.artists ar on a.ArtistId = ar.ArtistId 
WHERE 
    t.MediaTypeId != 3
GROUP BY 
    ar.ArtistId, ar.Name 
ORDER BY 'total time' DESC;

/* 3. Vad är den sammanlagda filstorleken för all video? */

SELECT SUM(CONVERT(bigint, t.Bytes)) as 'total video size' FROM music.tracks t WHERE MediaTypeId = 3;

/* 4. Vilket är det högsta antal artister som finns på en enskild spellista? */
/* 5. Vilket är det genomsnittliga antalet artister per spellista? */

SELECT AVG(subquery.[Number of artists]) FROM 
(
    SELECT 
        p.PlaylistId, 
        COUNT(DISTINCT a.ArtistId) as 'Number of artists'
    FROM 
        music.playlists p 
        JOIN music.playlist_track pt on p.PlaylistId = pt.PlaylistId 
        JOIN music.tracks t on pt.TrackId = t.TrackId 
        JOIN music.albums a on t.AlbumId = a.AlbumId 
    GROUP BY 
        p.PlaylistId
    
) subquery




