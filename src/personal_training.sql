-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys= ON;

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer
SELECT pt.session_id, 
       m.first_name || ' ' || m.last_name AS member_name, 
       pt.session_date, 
       pt.start_time, 
       pt.end_time
FROM personal_training_sessions pt
JOIN trainers t ON pt.trainer_id = t.trainer_id
JOIN members m ON pt.member_id = m.member_id
WHERE t.first_name = 'Ivy' AND t.last_name = 'Irwin';
