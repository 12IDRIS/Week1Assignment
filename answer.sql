
-- PLP Week 1 Database Assignment
-- Topic: School Management System

-- Create and select the database
CREATE DATABASE IF NOT EXISTS school_management;
USE school_management;

-- Create the students table
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE
);

-- Create the teachers table
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Create the courses table
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id)
        REFERENCES teachers(teacher_id)
);

-- Insert sample students if the table is empty
INSERT INTO students (first_name, last_name, age, email)
SELECT 'Idris', 'Mohamed', 18, 'idris@example.com'
WHERE NOT EXISTS (
    SELECT 1 FROM students WHERE email = 'idris@example.com'
);

INSERT INTO students (first_name, last_name, age, email)
SELECT 'Hawo', 'Kerow', 19, 'hawo@example.com'
WHERE NOT EXISTS (
    SELECT 1 FROM students WHERE email = 'hawo@example.com'
);

-- Insert sample teachers if the table is empty
INSERT INTO teachers (first_name, last_name, subject, email)
SELECT 'Ahmed', 'Ali', 'Mathematics', 'ahmed@example.com'
WHERE NOT EXISTS (
    SELECT 1 FROM teachers WHERE email = 'ahmed@example.com'
);

INSERT INTO teachers (first_name, last_name, subject, email)
SELECT 'Fatima', 'Hassan', 'English', 'fatima@example.com'
WHERE NOT EXISTS (
    SELECT 1 FROM teachers WHERE email = 'fatima@example.com'
);

-- Add courses for the corresponding teachers
INSERT INTO courses (course_name, teacher_id)
SELECT 'Mathematics', teacher_id
FROM teachers
WHERE email = 'ahmed@example.com'
AND NOT EXISTS (
    SELECT 1 FROM courses WHERE course_name = 'Mathematics'
);

INSERT INTO courses (course_name, teacher_id)
SELECT 'English', teacher_id
FROM teachers
WHERE email = 'fatima@example.com'
AND NOT EXISTS (
    SELECT 1 FROM courses WHERE course_name = 'English'
);

-- Display all tables
SHOW TABLES;

-- Display the records
SELECT * FROM students;
SELECT * FROM teachers;
SELECT * FROM courses;

-- Display courses with their teachers
SELECT
    courses.course_name,
    teachers.first_name,
    teachers.last_name
FROM courses
JOIN teachers
    ON courses.teacher_id = teachers.teacher_id;
