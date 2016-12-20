require 'nokogiri'
require 'sqlite3'
require 'open-uri'
require 'faker'
require 'chronic'

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
    1 => "https://theironyard.com/courses/net-engineering.html",
    2 => "https://www.theironyard.com/courses/java-and-clojure",
    3 => "https://theironyard.com/courses/rails-engineering.html",
    4 => "https://theironyard.com/courses/python-engineering.html",
    5 => "https://theironyard.com/courses/front-end-engineering.html",
    6 => "https://theironyard.com/courses/ui-design.html",
    7 => "https://theironyard.com/courses/mobile-engineering.html"
}

courses = []
locations = []

course_pages.each do |key, url|
  html = open(url)
  doc = Nokogiri::HTML(html)
  doc.css('.course-schedule-list li.row').each do |row|
    start_date = row.css("div span")[0].text.strip
    start_date = Chronic.parse(start_date).to_date.to_s
    location = row.css("div span")[1].text.strip
    courses.push({location: location, start_date: start_date, curriculum_id: key})
    locations.push(location)
  end
end

locations = locations.uniq.map.with_index do |name, idx|
  city, state = name.split(/,\s*/)
  state = "DC" if state == "D.C."
  {id: idx + 1, city: city, state: state}
end

courses = courses.map.with_index do |course, idx|
  city, state = course[:location].split(/,\s*/)
  state = "DC" if state == "D.C."
  location_id = locations.select { |loc| loc[:city] == city && loc[:state] == state }.first()
  location_id = location_id[:id] if location_id
  course[:location_id] = location_id
  course[:id] = idx + 1
  course
end

values = locations.map { |loc|
  str = [loc[:id], loc[:city].inspect, loc[:state].inspect].join(", ")
  "(#{str})"
}.join(",\n")

locations_sql = "INSERT INTO locations (id, city, state) VALUES \n#{values}\n;\n\n"

values = curricula.map { |cur|
  str = [cur[:id], cur[:title].inspect].join(", ")
  "(#{str})"
}.join(",\n")

curricula_sql = "INSERT INTO curricula (id, title) VALUES \n#{values}\n;\n\n"

values = courses.map { |crs|
  str = [crs[:id], crs[:location_id], crs[:curriculum_id], crs[:start_date].inspect].join(", ")
  "(#{str})"
}.join(",\n")

courses_sql = "INSERT INTO courses (id, location_id, curriculum_id, start_date) VALUES \n#{values}\n;\n\n"

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
puts curricula_sql
puts courses_sql
puts students_sql