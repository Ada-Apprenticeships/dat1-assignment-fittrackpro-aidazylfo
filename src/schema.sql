-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column



CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY, 
    name TEXT,
    address INTEGER,
    phone_number INTEGER,
    email INTEGER, 
    opening_hours TEXT,
);

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
    
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,	
    email TEXT,	
    phone_number TEXT,
    position TEXT,	
    hire_date TEXT,	
    location_id INTEGER,
);

CREATE TABLE equipment (
   equipment_id	INTEGER PRIMARY KEY,
   name	TEXT,
   type	TEXT,
   purchase_date TEXT,
   last_maintenance_date TEXT,	
   next_maintenance_date TEXT,	
   location_id INTEGER,
);

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT,
    capacity TEXT,
    duration TEXT,
    location_id PRIMARY KEY,
);

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY,
    class_id TEXT, 
    staff_id TEXT,
    start_time TEXT,
    end_time TEXT,
);

CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY,
    member_id TEXT,	
    type TEXT,	
    start_date TEXT,
    end_date TEXT,	
    status TEXT,
)

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY,
    member_id TEXT,
    location_id TEXT, 
    check_in_time TEXT,
    check_out_time TEXT,
);

CREATE TABLE class_attendance (
    class_attendance_id	INTEGER PRIMARY KEY,
    schedule_id	TEXT,
    member_id TEXT,
    attendance_status TEXT, 
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    member_id TEXT,
    amount TEXT,
    payment_date TEXT,	
    payment_method TEXT,
    payment_type TEXT,
);

CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id TEXT,
    staff_id TEXT,
    session_date TEXT,
    start_time TEXT,
    end_time TEXT,
    notes TEXT,
);

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id TEXT,
    measurement_date TEXT,
    weight TEXT,
    body_fat_percentage TEXT,
    muscle_mass TEXT,
    bmi TEXT,
);

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY,
    equipment_id TEXT,
    maintenance_date TEXT,
    description TEXT,
    staff_id TEXT,
);









-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal