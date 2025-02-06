-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

PRAGMA foreign_keys = ON;

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
CREATE TABLE MEMBERS (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    first_name TEXT,
    last_name TEXT,
    email TEXT,  
    phone_number TEXT,
    date_of_birth DATE,
    join_date DATE,
    emergency_contact_name TEXT,
    emergency_contact_phone TEXT
);

CREATE TABLE gym_visits (
    visit_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    member_id INTEGER NOT NULL,                   
    check_in_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    check_out_time TIMESTAMP NULL,                
    FOREIGN KEY (member_id) REFERENCES members(member_id) 
);

INSERT INTO gym_visits (member_id, check_in_time)
VALUES (123, CURRENT_TIMESTAMP);


-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

SELECT visit_id, member_id, check_in_time, check_out_time -- This extracts the day of the week from check_in_time and then returns a number which represents a day for example 0 for Sunday, 1 for Monday.
FROM gym_visits
WHERE member_id = 123
ORDER BY check_in_time DESC;


-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits

SELECT strftime('%w', check_in_time) AS day_of_week, COUNT(*) AS visit_count
FROM gym_visits
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_name TEXT
);

SELECT location_id, 
       AVG(daily_visits) AS avg_daily_attendance
FROM (
    SELECT location_id, 
           DATE(check_in_time) AS visit_date, 
           COUNT(*) AS daily_visits
    FROM gym_visits
    GROUP BY location_id, visit_date
) AS daily_data
GROUP BY location_id;
