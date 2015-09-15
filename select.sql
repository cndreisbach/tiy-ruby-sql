SELECT co.id, cu.title, l.city, l.state, i.name, co.start_date
FROM courses co
INNER JOIN curricula cu ON cu.id = co.curriculum_id
INNER JOIN locations l ON l.id = co.location_id
INNER JOIN instructors i ON i.id = co.instructor_id;

-- RoR only

SELECT co.id, cu.title, l.city, l.state, i.name, co.start_date
FROM courses co
INNER JOIN curricula cu ON cu.id = co.curriculum_id
INNER JOIN locations l ON l.id = co.location_id
INNER JOIN instructors i ON i.id = co.instructor_id
WHERE cu.title = 'Ruby on Rails';

-- in 2016

SELECT co.id, cu.title, l.city, l.state, i.name, co.start_date
FROM courses co
INNER JOIN curricula cu ON cu.id = co.curriculum_id
INNER JOIN locations l ON l.id = co.location_id
INNER JOIN instructors i ON i.id = co.instructor_id
WHERE co.start_date > '2016-01-01';
