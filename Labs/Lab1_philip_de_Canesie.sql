
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
    UserName = CONCAT(UserName, CAST(subquery.[row] as int))
FROM 
    (SELECT row = ROW_NUMBER() OVER (ORDER BY UserName) FROM NewUsers) as subquery 
    
WHERE
    UserName IN (SELECT UserName as u FROM NewUsers GROUP BY UserName HAVING COUNT(UserName) > 1);


GO


DELETE FROM NewUsers WHERE LEFT(ID, 2) < 70 AND Gender = 'Female';

GO 


INSERT INTO NewUsers (ID, UserName, [Password], Name, Gender, Email, Phone) 
VALUES (96, 'petnor', '05443ad5f94kf0193k', 'peter north', 'Male', 'peter.north@gmail.com', '0702-2346434')

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
