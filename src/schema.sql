-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY, 
    name TEXT,
    address TEXT,
    phone_number INTEGER,
    email TEXT, 
    opening_hours TEXT
);

DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email INTEGER,
    phone_number INTEGER,
    date_of_birth INTEGER,
    join_date TEXT,
    emergency_contact_name TEXT,
    emergency_contact_phone INTEGER
);
    
DROP TABLE IF EXISTS staff;

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,	
    email TEXT,	
    phone_number INTEGER,
    position TEXT,	
    hire_date TEXT,	
    location_id TEXT REFERENCE locations (location_id)
);

DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment (
   equipment_id	INTEGER PRIMARY KEY,
   name	TEXT,
   type	TEXT,
   purchase_date TEXT,
   last_maintenance_date TEXT,	
   next_maintenance_date TEXT,	
   location_id TEXT REFERENCE locations (location_id)
);

DROP TABLE IF EXISTS classes;

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT,
    capacity TEXT,
    duration TEXT,
    location_id TEXT
);

DROP TABLE IF EXISTS class_attendance;

CREATE TABLE class_attendance (
    class_attendance_id	INTEGER PRIMARY KEY,
    schedule_id	TEXT, REFERENCE class_attendance (schedule_id)
    member_id TEXT, REFERENCE members (member_id)
    attendance_status TEXT 
);

DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    member_id TEXT, REFERENCE  (member_id)
    amount INTEGER,
    payment_date TEXT,	
    payment_method TEXT,
    payment_type TEXT
);

DROP TABLE IF EXISTS personal_training_sessions;

CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id TEXT, REFERENCE members (member_id)
    staff_id TEXT, REFERENCE staff (staff_id)
    session_date TEXT,
    start_time TEXT,
    end_time TEXT,
    notes TEXT
);

DROP TABLE IF EXISTS member_health_metrics;

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id TEXT, REFERENCE members (member_id)
    measurement_date TEXT,
    weight TEXT,
    body_fat_percentage TEXT,
    muscle_mass TEXT,
    bmi TEXT
);

DROP TABLE IF EXISTS equipment_maintenance_log;

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT, -- means you dont have to apply a value to the integer the database will do it 
    equipment_id TEXT,
    maintenance_date TEXT,
    description TEXT,
    staff_id TEXT REFERENCE staff (staff_id)
);









-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal