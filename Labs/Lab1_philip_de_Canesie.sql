
-- MoonMissions

SELECT 
    Spacecraft, 
    [Launch date], 
    [Carrier rocket], 
    Operator, 
    [Mission type] 
INTO 
    SuccessfulMissions 
FROM 
    MoonMissions 
WHERE 
    Outcome LIKE '%Success%';

GO


UPDATE 
    SuccessfulMissions 
SET 
    Operator = TRIM(Operator);

GO


UPDATE 
    SuccessfulMissions 
SET 
    Spacecraft = CASE 
        WHEN Spacecraft LIKE '%(%)%' 
        THEN TRIM(STUFF(Spacecraft, CHARINDEX('(', Spacecraft, 0), CHARINDEX(')', Spacecraft, 0) - CHARINDEX('(', Spacecraft, 0) + 1, '')) 
        ELSE Spacecraft 
        END;

GO


SELECT 
    Operator, 
    [Mission type],
    COUNT([Mission type]) AS 'Mission count' 
FROM 
    SuccessfulMissions 
GROUP BY 
    Operator, 
    [Mission type] 
HAVING 
    COUNT([Mission type]) > 1 
ORDER BY 
    Operator, 
    [Mission type];

GO


-- Users

SELECT 
    ID, 
    UserName, 
    [Password], 
    Name = CONCAT(FirstName, ' ', LastName), 
    Gender = CASE 
        WHEN (CAST(SUBSTRING(ID, LEN(ID) - 1, 1) as int) % 2) = 0 
        THEN 'Female' 
        ELSE 'Male' 
        END,
    Email, Phone 
INTO 
    NewUsers 
FROM 
    Users;

GO


SELECT 
    UserName, 
    Total = COUNT(UserName) 
FROM 
    NewUsers 
GROUP BY 
    UserName 
HAVING 
    COUNT(UserName) > 1;

GO


UPDATE
    NewUsers
SET 
    UserName = CONCAT(SUBSTRING(UserName, 1, 4), LEFT(ID, 1), RIGHT(ID, 1))
WHERE
    UserName IN (SELECT UserName as u FROM NewUsers GROUP BY UserName HAVING COUNT(UserName) > 1);


GO


DELETE FROM NewUsers WHERE LEFT(ID, 2) < 70 AND Gender = 'Female';

GO 


INSERT INTO NewUsers (ID, UserName, [Password], Name, Gender, Email, Phone) 
VALUES ('960430-4532', 'petnor', '05443ad5f94kf0193k', 'peter north', 'Male', 'peter.north@gmail.com', '0702-2346434')

GO


SELECT 
    Gender,
    AVG(DATEDIFF(YEAR, CAST('19' + SUBSTRING(ID, 1, 2) + '-' + SUBSTRING(ID, 3, 2) + '-' + SUBSTRING(ID, 5, 2) AS DATE), GETDATE())) as 'Avarage age' 
FROM 
    NewUsers 
GROUP BY 
    Gender;

GO


-- Company (Joins) 

SELECT 
    p.Id, 
    p.ProductName as Product, 
    s.CompanyName as Supplier, 
    c.CategoryName as Category 
FROM 
    company.products p 
JOIN 
    company.suppliers s on p.SupplierId = s.Id 
JOIN 
    company.categories c on p.CategoryId = c.Id;

GO


SELECT 
    RegionDescription as Regions,
    COUNT(DISTINCT et.EmployeeId) as 'Employee Count'
FROM 
    company.regions r 
JOIN 
    company.territories t on r.Id = t.RegionId 
JOIN 
    company.employee_territory et on t.Id = et.TerritoryId 
GROUP BY 
    RegionId,
    RegionDescription;

GO

SELECT 
    DISTINCT E1.Id,
    CONCAT(E1.TitleOfCourtesy, E1.FirstName,' ', E1.LastName) as 'Name',
    CASE 
        WHEN 
            E1.ReportsTo 
        IS NULL THEN 
            'Nobody!' 
        ELSE 
            CONCAT(E2.TitleOfCourtesy, E2.FirstName,' ', E2.LastName) 
    END as 'Reports to' 
FROM 
    company.employees E1 
LEFT JOIN 
    company.employees E2 on E1.ReportsTo = E2.Id;


