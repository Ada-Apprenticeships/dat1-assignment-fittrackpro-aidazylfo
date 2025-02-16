-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys= ON;

-- Staff Management Queries
-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
SELECT staff_id, first_name, last_name, role
FROM staff
ORDER BY role;

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days
SELECT t.trainer_id, 
       t.first_name || ' ' || t.last_name AS trainer_name, 
       COUNT(pt.session_id) AS session_count
FROM trainers t
JOIN personal_training_sessions pt ON t.trainer_id = pt.trainer_id
WHERE pt.session_date BETWEEN CURRENT_DATE AND DATE(CURRENT_DATE, '+30 day')
GROUP BY t.trainer_id
HAVING COUNT(pt.session_id) > 0;
