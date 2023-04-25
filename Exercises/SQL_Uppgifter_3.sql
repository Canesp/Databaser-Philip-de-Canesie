/* 1. Företagets totala produktkatalog består av 77 unika produkter. Om vi kollar bland våra ordrar, hur stor andel av dessa produkter har vi någon gång leverarat till London? */

DECLARE @London_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId) FROM company.orders o JOIN company.order_details od on o.id = od.OrderId WHERE o.ShipCity = 'LONDON');
DECLARE @Num_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId) FROM company.order_details od)

PRINT(@London_products / @Num_products)


/* 2. Till vilken stad har vi levererat flest unika produkter? */

SELECT o.ShipCity, COUNT(DISTINCT od.ProductId) as 'Unique products' FROM company.orders o JOIN company.order_details od on o.id = od.OrderId GROUP BY o.ShipCity ORDER BY 'Unique products' DESC;

/* 3. Av de produkter som inte längre finns I vårat sortiment, hur mycket har vi sålt för totalt till Tyskland? */

SELECT * FROM company.order_details;
SELECT * FROM company.orders;
SELECT * FROM company.suppliers;
SELECT * FROM company.products;


/* 4. För vilken produktkategori har vi högst lagervärde? */

SELECT * FROM company.categories;
SELECT * FROM company.products;

SELECT p.CategoryId, ROUND(SUM(p.UnitPrice * p.UnitsInStock), 2) as 'Value' FROM company.categories c JOIN company.products p on c.Id = p.CategoryId GROUP BY p.CategoryId ORDER BY 'Value' DESC;
