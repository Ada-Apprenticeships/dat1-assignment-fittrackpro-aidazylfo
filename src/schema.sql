-- FitTrack Pro Database Schema

.open fittrackpro.db
.mode column

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS locations; -- ensures the table is deleted before recreating it 

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY, 
    name TEXT,
    address TEXT,
    phone_number TEXT,
    email TEXT, 
    opening_hours TEXT
);


DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    phone_number TEXT,
    date_of_birth DATE,
    join_date DATE,
    emergency_contact_name TEXT,
    emergency_contact_phone TEXT
); 
   
   
DROP TABLE IF EXISTS staff;

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,	
    email TEXT,	
    phone_number TEXT,
    position TEXT,
    hire_date DATE,	
    location_id INTEGER, 
    FOREIGN KEY (location_id) REFERENCES locations (location_id)
);


DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment (
   equipment_id	INTEGER PRIMARY KEY,
   name	TEXT,
   type	TEXT,
   purchase_date DATE,
   last_maintenance_date DATE,	
   next_maintenance_date DATE,	
   location_id INTEGER, 
   FOREIGN KEY (location_id) REFERENCES locations (location_id)
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


DROP TABLE IF EXISTS class_schedule;

CREATE TABLE class_schedule(   
    schedule_id INTEGER PRIMARY KEY,
    class_id INTEGER,
    staff_id INTEGER,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),   
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
);


DROP TABLE IF EXISTS memberships; 

CREATE TABLE memberships(
    membership_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    type TEXT,
    start_date DATETIME,
    end_date DATETIME,	
    status TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);


DROP TABLE IF EXISTS attendance;

CREATE TABLE attendance(
    attendance_id INTEGER PRIMARY KEY,  
    member_id INTEGER,                  
    location_id INTEGER,                
    check_in_time DATETIME,              
    check_out_time DATETIME,             
    FOREIGN KEY (member_id) REFERENCES members(member_id),  
    FOREIGN KEY (location_id) REFERENCES locations(location_id)  
);


DROP TABLE IF EXISTS class_attendance; 

CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY,
    schedule_id INTEGER,  
    member_id INTEGER,  
    attendance_status TEXT,
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),  
    FOREIGN KEY (member_id) REFERENCES members(member_id)  
);


DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    member_id INTEGER,  
    amount REAL, 
    payment_date DATE,  
    payment_method TEXT,
    payment_type TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)  
);    


DROP TABLE IF EXISTS personal_training_sessions;

CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id INTEGER,  
    staff_id INTEGER,   
    session_date DATE,  
    start_time DATETIME,  
    end_time DATETIME,   
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id), 
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
);

DROP TABLE IF EXISTS member_health_metrics;

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id INTEGER, 
    measurement_date DATE,
    weight TEXT,
    body_fat_percentage TEXT,
    muscle_mass TEXT,
    bmi TEXT,
    FOREIGN KEY (member_id) REFERENCES members (member_id)
);


DROP TABLE IF EXISTS equipment_maintenance_log;

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    equipment_id INTEGER,
    maintenance_date DATE,
    description TEXT,
    staff_id INTEGER,
    FOREIGN KEY (equipment_id) REFERENCES equipment (equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);