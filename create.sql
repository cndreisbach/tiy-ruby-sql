CREATE TABLE locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    city VARCHAR(255) NOT NULL,
    state CHAR(2) NOT NULL
);

CREATE TABLE curricula (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_id INTEGER NOT NULL REFERENCES locations(id),
    curriculum_id INTEGER NOT NULL REFERENCES curricula(id),
    start_date DATE NOT NULL
);

CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    course_id INTEGER NOT NULL REFERENCES courses(id)
);