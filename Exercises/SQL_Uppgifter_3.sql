/* 1. Företagets totala produktkatalog består av 77 unika produkter. Om vi kollar bland våra ordrar, hur stor andel av dessa produkter har vi någon gång leverarat till London? */

DECLARE @London_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId) FROM company.orders o JOIN company.order_details od on o.id = od.OrderId WHERE o.ShipCity = 'LONDON');
DECLARE @Num_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId) FROM company.order_details od)

PRINT(@London_products / @Num_products)


/* 2. Till vilken stad har vi levererat flest unika produkter? */

SELECT o.ShipCity, COUNT(DISTINCT od.ProductId) as 'Unique products' FROM company.orders o JOIN company.order_details od on o.id = od.OrderId GROUP BY o.ShipCity ORDER BY 'Unique products' DESC;

/* 3. Av de produkter som inte längre finns I vårat sortiment, hur mycket har vi sålt för totalt till Tyskland? */

SELECT ROUND(SUM(od.UnitPrice * od.Quantity), 2) as 'Sold ($)' FROM company.orders o JOIN company.order_details od on o.Id = od.OrderId JOIN company.products p on od.ProductId = p.Id WHERE o.ShipCountry = 'Germany' AND p.Discontinued = 1;


/* 4. För vilken produktkategori har vi högst lagervärde? */

SELECT p.CategoryId, ROUND(SUM(p.UnitPrice * p.UnitsInStock), 2) as 'Value' FROM company.categories c JOIN company.products p on c.Id = p.CategoryId GROUP BY p.CategoryId ORDER BY 'Value' DESC;

/* 5. Från vilken leverantör har vi sålt flest produkter totalt under sommaren 2013? */

SELECT s.Id, s.CompanyName , SUM(od.Quantity) as 'Num Products' FROM company.orders o JOIN company.order_details od on o.Id = od.OrderId JOIN company.products p on od.ProductId = p.Id JOIN company.suppliers s on p.SupplierId = s.Id WHERE o.OrderDate BETWEEN '2013-06-21' AND '2013-09-23' GROUP BY s.Id, s.CompanyName ORDER BY 'Num Products' DESC;



