SELECT co.id, cu.title, l.city, l.state, co.start_date
FROM courses co
INNER JOIN curricula cu ON cu.id = co.curriculum_id
INNER JOIN locations l ON l.id = co.location_id;

-- RoR only

SELECT co.id, cu.title, l.city, l.state, co.start_date
FROM courses co
INNER JOIN curricula cu ON cu.id = co.curriculum_id
INNER JOIN locations l ON l.id = co.location_id
WHERE cu.title = 'Ruby on Rails';

-- in 2016

-- SELECT co.id, cu.title, l.city, l.state, i.name, co.start_date
-- FROM courses co
-- INNER JOIN curricula cu ON cu.id = co.curriculum_id
-- INNER JOIN locations l ON l.id = co.location_id
-- INNER JOIN instructors i ON i.id = co.instructor_id
-- WHERE co.start_date > '2016-01-01';

-- All courses in Durham
SELECT curricula.title, courses.start_date, locations.city, locations.state
FROM courses
INNER JOIN curricula ON courses.curriculum_id = curricula.id
INNER JOIN locations ON locations.id = courses.location_id
WHERE locations.city = 'Durham' AND locations.state = 'NC';

SELECT curricula.title, courses.start_date, locations.city, locations.state
FROM locations
INNER JOIN curricula ON courses.curriculum_id = curricula.id
INNER JOIN courses ON locations.id = courses.location_id
WHERE locations.city = 'Durham' AND locations.state = 'NC';

SELECT curricula.title, courses.start_date, locations.city, locations.state
FROM courses, curricula, locations
WHERE courses.curriculum_id = curricula.id
AND locations.id = courses.location_id
AND locations.city = 'Durham'
AND locations.state = 'NC';
