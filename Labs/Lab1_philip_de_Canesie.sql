
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

