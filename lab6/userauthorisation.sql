CREATE DATABASE IF NOT EXISTS userauthorisation;
USE userauthorisation;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(80) UNIQUE NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    subject VARCHAR(50),
    grade VARCHAR(5),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
INSERT INTO grades (user_id, subject, grade) VALUES 
-- Student 1
(1, 'Mathematics', 'A'),
(1, 'Science', 'B+'),
(1, 'English', 'A-'),
(1, 'History', 'B'),
(1, 'Computer Science', 'A'),

-- Student 2
(2, 'Mathematics', 'B'),
(2, 'Science', 'A'),
(2, 'English', 'B+'),
(2, 'History', 'A-'),
(2, 'Computer Science', 'B+'),

-- Student 3
(3, 'Mathematics', 'A-'),
(3, 'Science', 'B'),
(3, 'English', 'A'),
(3, 'History', 'B+'),
(3, 'Computer Science', 'A'),

-- Student 4
(4, 'Mathematics', 'A'),
(4, 'Science', 'B-'),
(4, 'English', 'C'),
(4, 'History', 'B+'),
(4, 'Computer Science', 'A'),

-- Student 5
(5, 'Mathematics', 'A-'),
(5, 'Science', 'B'),
(5, 'English', 'A'),
(5, 'History', 'B+'),
(5, 'Computer Science', 'A');

SELECT * FROM users;
SELECT * FROM grades;

-- Find duplicate users (same username & email)
SELECT username, email, COUNT(*) 
FROM users 
GROUP BY username, email 
HAVING COUNT(*) > 1;

-- Find duplicate grades (same user_id & subject)
SELECT user_id, subject, COUNT(*) 
FROM grades 
GROUP BY user_id, subject 
HAVING COUNT(*) > 1;

DELETE u1 
FROM users u1
JOIN users u2 
ON u1.username = u2.username AND u1.email = u2.email
WHERE u1.id > u2.id;
DELETE g1 
FROM grades g1
JOIN grades g2 
ON g1.user_id = g2.user_id AND g1.subject = g2.subject
WHERE g1.grade_id > g2.grade_id;
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM users;
SELECT * FROM grades;




