-- Create the Machines table
CREATE TABLE Machines (
    machineID INT PRIMARY KEY,
    temperature INT CHECK (temperature BETWEEN 0 AND 100),
    wear INT CHECK (wear BETWEEN 0 AND 100),
    time_since_power_on INT CHECK (time_since_power_on BETWEEN 1 AND 14400),
    status ENUM('on', 'off')
);

-- Insert 100 rows into the Machines table
INSERT INTO Machines (machineID, temperature, wear, time_since_power_on, status)
SELECT 
    FLOOR(RAND() * 900000) + 100000 AS machineID,
    FLOOR(RAND() * 101) AS temperature,
    FLOOR(RAND() * 101) AS wear,
    FLOOR(RAND() * 14400) + 1 AS time_since_power_on,
    IF(RAND() < 0.5, 'on', 'off') AS status
FROM 
    (SELECT @rownum := @rownum + 1 AS rn FROM 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION 
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t1,
    (SELECT @rownum := 0) t2) r
LIMIT 100;  -- Limit to 100 rows
