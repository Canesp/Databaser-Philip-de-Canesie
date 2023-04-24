/* 1. Företagets totala produktkatalog består av 77 unika produkter. Om vi kollar bland våra ordrar, hur stor andel av dessa produkter har vi någon gång leverarat till London? */

SELECT CAST(COUNT(CASE WHEN o.ShipCity = 'London' THEN 1 ELSE null END) as float) / CAST(COUNT(*) as float) as 'Andel till London' FROM company.orders o JOIN company.order_details od on o.id = od.OrderId;