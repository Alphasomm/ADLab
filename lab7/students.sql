Create Database students;
use students ;
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    class VARCHAR(50),
    subject VARCHAR(50),
    marks INT
);
drop table studentsinfo;
INSERT INTO students (name, age, class, subject, marks) VALUES
-- Aarav Sharma
('Aarav Sharma', 16, '10th Grade', 'Mathematics', 89),
('Aarav Sharma', 16, '10th Grade', 'Science', 85),
('Aarav Sharma', 16, '10th Grade', 'English', 90),

-- Ishita Verma
('Ishita Verma', 15, '9th Grade', 'Mathematics', 92),
('Ishita Verma', 15, '9th Grade', 'History', 88),
('Ishita Verma', 15, '9th Grade', 'Geography', 86),

-- Rohan Iyer
('Rohan Iyer', 17, '11th Grade', 'Physics', 85),
('Rohan Iyer', 17, '11th Grade', 'Chemistry', 82),
('Rohan Iyer', 17, '11th Grade', 'Computer Science', 91),

-- Sneha Nair
('Sneha Nair', 16, '10th Grade', 'English', 90),
('Sneha Nair', 16, '10th Grade', 'Mathematics', 87),
('Sneha Nair', 16, '10th Grade', 'Science', 89),

-- Vihaan Gupta
('Vihaan Gupta', 17, '11th Grade', 'Chemistry', 78),
('Vihaan Gupta', 17, '11th Grade', 'Mathematics', 80),
('Vihaan Gupta', 17, '11th Grade', 'Physics', 84),

-- Ananya Rao
('Ananya Rao', 15, '9th Grade', 'History', 88),
('Ananya Rao', 15, '9th Grade', 'Geography', 85),
('Ananya Rao', 15, '9th Grade', 'English', 90),

-- Karan Mehta
('Karan Mehta', 16, '10th Grade', 'Biology', 84),
('Karan Mehta', 16, '10th Grade', 'Mathematics', 82),
('Karan Mehta', 16, '10th Grade', 'Science', 86),

-- Neha Kulkarni
('Neha Kulkarni', 17, '11th Grade', 'Computer Science', 91),
('Neha Kulkarni', 17, '11th Grade', 'Mathematics', 89),
('Neha Kulkarni', 17, '11th Grade', 'Physics', 83),

-- Arjun Malhotra
('Arjun Malhotra', 15, '9th Grade', 'Geography', 87),
('Arjun Malhotra', 15, '9th Grade', 'History', 85),
('Arjun Malhotra', 15, '9th Grade', 'Mathematics', 88),

-- Pooja Reddy
('Pooja Reddy', 16, '10th Grade', 'Mathematics', 94),
('Pooja Reddy', 16, '10th Grade', 'Science', 92),
('Pooja Reddy', 16, '10th Grade', 'English', 93);

USE students;
drop table grades;
CREATE TABLE grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject VARCHAR(50),
    grade VARCHAR(4),
    -- add other columns as needed
    FOREIGN KEY (student_id) REFERENCES students(id)
);
INSERT INTO grades (student_id, subject, grade)
VALUES
(1, 'Mathematics', 'A'),
(2, 'Science', 'B+'),
(3, 'English', 'A-'),
(4, 'Mathematics', 'A+'),
(5, 'History', 'B'),
(6, 'Geography', 'A-'),
(7, 'Physics', 'B+'),
(8, 'Chemistry', 'B-'),
(9, 'Computer Science', 'A'),
(10, 'English', 'A-'),
(11, 'Mathematics', 'A'),
(12, 'Science', 'B+'),
(13, 'Chemistry', 'B'),
(14, 'Mathematics', 'A+'),
(15, 'Physics', 'A'),
(16, 'History', 'B+');

-- 7. Verify data in "students" and "grades"
SELECT * FROM students;
SELECT * FROM grades;

Select *from students;



