require 'nokogiri'
require 'sqlite3'
require 'open-uri'
require 'faker'

locations = [
    {id: 1, city: 'Atlanta', state: 'GA'},
    {id: 2, city: 'Austin', state: 'TX'},
    {id: 3, city: 'Charleston', state: 'SC'},
    {id: 4, city: 'Charlotte', state: 'NC'},
    {id: 5, city: 'Columbia', state: 'SC'},
    {id: 6, city: 'Durham', state: 'NC'},
    {id: 7, city: 'Greenville', state: 'SC'},
    {id: 8, city: 'Houston', state: 'TX'},
    {id: 9, city: 'Indianapolis', state: 'ID'},
    {id: 10, city: 'Las Vegas', state: 'NV'},
    {id: 11, city: 'Little Rock', state: 'AR'},
    {id: 12, city: 'Nashville', state: 'TN'},
    {id: 13, city: 'Orlando', state: 'FL'},
    {id: 14, city: 'Raleigh', state: 'NC'},
    {id: 15, city: 'Salt Lake City', state: 'UT'},
    {id: 16, city: 'Tampa Bay-St. Petersburg', state: 'FL'},
    {id: 17, city: 'Washington', state: 'DC'}
]

curricula = [
    {id: 1, title: 'C# and .NET'},
    {id: 2, title: 'Java and Clojure'},
    {id: 3, title: 'Ruby on Rails'},
    {id: 4, title: 'Python'},
    {id: 5, title: 'Front End'},
    {id: 6, title: 'UI Design'},
    {id: 7, title: 'iOS'}
]

course_pages = {
    1 => "http://theironyard.com/courses/net-engineering",
    2 => "http://theironyard.com/courses/java-engineering",
    3 => "http://theironyard.com/courses/rails-engineering",
    4 => "http://theironyard.com/courses/python-engineering",
    5 => "http://theironyard.com/courses/front-end-engineering",
    6 => "http://theironyard.com/courses/ui-design",
    7 => "http://theironyard.com/courses/mobile-engineering"
}

courses = []
instructors = []

course_pages.each do |key, url|
  html = open(url)
  doc = Nokogiri::HTML(html)
  doc.css('.class-table tr').each do |row|
    location = row.css("td[itemprop='name']").text.strip
    start_date = row.css("td[itemprop='startDate']").last['content']
    instructor = row.css("td:nth-child(3)").text.strip
    instructors.push(instructor)
    courses.push({location: location, start_date: start_date, 
      instructor: instructor, curriculum_id: key})
  end
end

instructors = instructors.uniq.map.with_index do |name, idx|
  {id: idx + 1, name: name}
end

courses = courses.map.with_index do |course, idx|
  city, state = course[:location].split(/,\s*/)
  state = "DC" if state == "D.C."
  location_id = locations.select { |loc| loc[:city] == city && loc[:state] == state }.first()
  location_id = location_id[:id] if location_id
  instructor_id = instructors.select { |ins| ins[:name] == course[:instructor] }.first()
  instructor_id = instructor_id[:id] if instructor_id
  course[:location_id] = location_id
  course[:instructor_id] = instructor_id
  course[:id] = idx + 1
  course
end

values = locations.map { |loc|
  str = [loc[:id], loc[:city].inspect, loc[:state].inspect].join(", ")
  "(#{str})"
}.join(",\n")

locations_sql = "INSERT INTO locations (id, city, state) VALUES \n#{values}\n;\n\n"

values = instructors.map { |ins|
  str = [ins[:id], ins[:name].inspect].join(", ")
  "(#{str})"
}.join(",\n")

instructors_sql = "INSERT INTO instructors (id, name) VALUES \n#{values}\n;\n\n"

values = curricula.map { |cur|
  str = [cur[:id], cur[:title].inspect].join(", ")
  "(#{str})"
}.join(",\n")

curricula_sql = "INSERT INTO curricula (id, title) VALUES \n#{values}\n;\n\n"

values = courses.map { |crs|
  str = [crs[:id], crs[:location_id], crs[:instructor_id], crs[:curriculum_id], crs[:start_date].inspect].join(", ")
  "(#{str})"
}.join(",\n")

courses_sql = "INSERT INTO courses (id, location_id, instructor_id, curriculum_id, start_date) VALUES \n#{values}\n;\n\n"

students = []

courses.each do |course|
  num_students = rand(5) + 10
  num_students.times do
    students.push({name: Faker::Name.name, course_id: course[:id]})
  end
end

values = students.map { |stu|
  str = [stu[:course_id], stu[:name].inspect].join(", ")
  "(#{str})"
}.join(",\n")

students_sql = "INSERT INTO students (course_id, name) VALUES \n#{values}\n;\n\n"

puts locations_sql
puts instructors_sql
puts curricula_sql
puts courses_sql
puts students_sql