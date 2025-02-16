-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys= ON;

-- Membership Management Queries
-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
SELECT member_id, first_name, last_name, membership_type, join_date
FROM memberships
WHERE membership_status = 'Active'; -- This filters the results to only include members that are active.

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
SELECT membership_type, -- The line of code below extracts the time in seconds from bith columns, subtracts them to get the total visit duration in seconds. Then divides it by 60 to get total in minutes.
       AVG((EXTRACT(EPOCH FROM exit_time) - EXTRACT(EPOCH FROM entry_time)) / 60) AS avg_visit_duration_minutes 
FROM gym_visits
INNER JOIN memberships USING (member_id)
GROUP BY membership_type; -- This groups the results by membership type so we calculate the average separately for each type.


-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT member_id, first_name, last_name, email, end_date
FROM memberships
WHERE end_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '1 year'); --This filters memberships to only include those with an end date between today and 1 year from today.
