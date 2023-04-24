SELECT * FROM countries;
SELECT * FROM cities;

SELECT cities.id, cities.name, countries.name FROM cities JOIN countries on cities.countryid = countries.id;

SELECT c.name as 'Kurs', s.name as 'Student' FROM courses c JOIN coursesStudents cs on c.id = cs.courseid JOIN Students s on s.id = cs.studentid;

SELECT c.name as 'Courses', COUNT(cs.courseid) as 'Number of students', STRING_AGG(s.name, ', ') as 'Students' FROM courses c left JOIN coursesStudents cs on c.id = cs.courseid left JOIN Students s on s.id = cs.studentid GROUP BY c.name;