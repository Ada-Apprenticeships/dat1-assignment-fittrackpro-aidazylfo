-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys= ON; 

-- Class Scheduling Queries
-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
SELECT class_id, class_name, instructor_name
FROM classes
JOIN instructors USING (instructor_id);

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
SELECT class_id, name, start_time, end_time, available_spots
FROM classes
WHERE class_date = '2025-02-01'
AND available_spots > 0;

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
INSERT INTO class_attendance (member_id, class_id, class_date)  
VALUES (11, 3, '2025-02-01');

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration
DELETE FROM class_attendance  
WHERE member_id = 2 -- Ensures you delete the registration only for member 2 
AND schedule_id = 7;  

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes
SELECT class_id, class_name, COUNT(member_id) AS registration_count --Selects the columns and counts the number of registered members renaming it as registration_count.
FROM classes  
JOIN class_attendance ON classes.class_id = class_attendance.class_id  --This joins the class_attendance table with classes table  which matches records where class_id is the same in both tables.
GROUP BY class_id, class_name  -- This groups the results by class_id and class_name so the registration count is calculated for each class separately.
ORDER BY registration_count DESC --This sorts the classes in descending order based on the number of registrations and shows the most popular classes first. 
LIMIT 3; --Only the top 3 most popular classes.

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member
SELECT COUNT(class_id) * 1.0 / COUNT(DISTINCT member_id) AS avg_classes_per_member -- * 1.0 ensures the result is a decimal instead of an integer which allow us to represent the average more precisely.
FROM class_attendance;
