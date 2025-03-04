CREATE DATABASE school_management;

\c school_management;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL
);

INSERT INTO users (username, password, role) VALUES
('admin', 'admin123', 'ADMIN'),
('teacher1', 'teacher123', 'TEACHER'),
('student1', 'student123', 'STUDENT');
