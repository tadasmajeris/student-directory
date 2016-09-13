# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november,
#     hobbies: ['puzzles', 'eating humans'],
#     country: 'America', height: 1.7 },
#   {name: "Darth Vader", cohort: :november, hobbies: ['conquering the universe', 'red lightsabers'], height: 2},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students, args = {})
  first_letter = args[:first_letter]
  name_length = args[:name_length]
  if first_letter
    students = students.select do |student|
      student[:name][0].downcase == first_letter.downcase
    end
  end
  if name_length
    students = students.select do |student|
      student[:name].length < name_length
    end
  end

  i = 0
  while students.count > 0
    student = students.shift
    i += 1
    puts "#{i}. #{student[:name]}"
    # print students hobbies, country, height, etc
    student.each do |k, v|
      if (k != :name) && (v.to_s != '')
        puts "#{k}: #{(v.is_a? Array) ? v.join(', ') : v}"
      end
    end
    puts
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

def input_students
  students = []
  puts "Enter the name of student No.1"
  name = gets.chomp

  while !name.empty? do
    hobbies = []
    puts "Enter student's hobbies: (to finish, hit return twice)"
    hobby = gets.chomp
    while !hobby.empty? do
      hobbies << hobby
      hobby = gets.chomp
    end

    puts "Enter student's country:"
    country = gets.chomp

    puts "Enter student's height:"
    height = gets.chomp

    students << { name: name, cohort: :november,
                  hobbies: hobbies, height: height,
                  country: country }

    puts "Now we have #{students.count} students"
    puts
    puts "Enter the name of student No.#{students.count+1} (or hit return to finish)"
    name = gets.chomp
  end

  students
end

students = input_students
print_header
print(students, {name_length: 30})
print_footer(students)
