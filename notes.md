- select all curricula
- select all locations
- select all locations in NC
- select all courses
- join curriculum, location and instructor to courses

- find start dates
- find first start date
- find last start date

- find count for each class
- find locations with more than one class
- SELECT l.id, l.city, l.state, COUNT(*) FROM locations l LEFT JOIN courses c ON c.location_id = l.id GROUP BY l.id HAVING COUNT(*) > 1;

- SELECT
- FROM
- WHERE
- GROUP
- HAVING
- INNER JOIN
- LEFT JOIN

- having an instructor_id on courses is invalid -- some courses have multiple instructors
- what if a student took multiple classes?