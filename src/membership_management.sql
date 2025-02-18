-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys= ON;

-- Membership Management Queries
-- 1. List all active memberships
-- TODO: Write a query to list all active memberships
SELECT memberships.member_id, members.first_name, members.last_name, 
       memberships.type AS membership_type, memberships.start_date
FROM memberships
JOIN members ON memberships.member_id = members.member_id
WHERE memberships.status = 'Active'; -- This filters the results to only include members that are active.

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
SELECT memberships.type, 
       AVG(strftime('%s', attendance.check_out_time) - strftime('%s', attendance.check_in_time)) / 60 AS avg_visit_duration_minutes
FROM attendance
JOIN memberships ON attendance.member_id = memberships.member_id
WHERE attendance.check_out_time IS NOT NULL -- Ensures only completed visits are considered
GROUP BY memberships.type; -- This groups the results by membership type so we calculate the average separately for each type.


-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
SELECT members.member_id, members.first_name, members.last_name, members.email, memberships.end_date
FROM memberships
JOIN members ON memberships.member_id = members.member_id
WHERE memberships.end_date BETWEEN DATE('now') AND DATE('now', '+1 year');