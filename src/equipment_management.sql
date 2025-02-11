-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys= ON;

-- Equipment Management Queries
-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance

SELECT equipment_id, name, next_maintenance_date
FROM equipment
WHERE next_maintenance_date BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY; --Filters the records to display equipment that is due for maintenance within the next 30 days.

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

SELECT equipment_type, COUNT(*) AS count
FROM equipment
WHERE in_stock > 0 -- Where stock is more than 0 so counts only equipment in stock 
GROUP BY equipment_type;

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)

SELECT equipment_type, AVG(DATEDIFF(CURDATE(), purchase_date)) AS avg_age_days
FROM equipment
GROUP BY equipment_type;
