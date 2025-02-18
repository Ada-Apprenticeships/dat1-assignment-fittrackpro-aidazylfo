-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys= ON; 

-- Class Scheduling Queries
-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
SELECT c.class_id, 
       c.name AS class_name, 
       s.first_name || ' ' || s.last_name AS instructor_name
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN staff s ON cs.staff_id = s.staff_id
WHERE s.position = 'Trainer';

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
SELECT c.class_id, 
       c.name AS class_name, 
       c.capacity - COUNT(ca.member_id) AS available_spots
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
WHERE cs.start_time BETWEEN '2025-02-01' AND '2025-02-01'
GROUP BY c.class_id, c.name, c.capacity
HAVING available_spots > 0;


-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
INSERT INTO class_attendance (member_id, schedule_id, attendance_status)  
VALUES (11, 3, 'Registered');

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
DELETE FROM class_attendance  
WHERE member_id = 2 -- Ensures you delete the registration only for member 2 
AND schedule_id = 7;  

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes
SELECT c.class_id, 
       c.name AS class_name, 
       COUNT(ca.member_id) AS registration_count
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id  --This joins the class_attendance table with classes table  which matches records where class_id is the same in both tables.
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id
GROUP BY c.class_id, c.name  -- This groups the results by class_id and class_name so the registration count is calculated for each class separately.
ORDER BY registration_count DESC --This sorts the classes in descending order based on the number of registrations and shows the most popular classes first. 
LIMIT 5; --Only the top 3 most popular classes.

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member
SELECT COUNT(ca.class_attendance_id) * 1.0 / COUNT(DISTINCT ca.member_id) AS avg_classes_per_member
FROM class_attendance ca;