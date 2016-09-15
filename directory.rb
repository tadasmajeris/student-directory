# @students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november,
#     hobbies: ['puzzles', 'eating humans'],
#     country: 'America', height: 1.7 },
#   {name: "Darth Vader", cohort: :september, hobbies: ['universe', 'red lightsabers'], height: 2},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :september},
#   {name: "The Wicked Witch of the West", cohort: :november, country: "Lithuania"},
#   {name: "Terminator", cohort: :january},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :january},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]
@students = []
@max_chars = {}

def print_header
  puts
  puts "The students of Villains Academy"
  print_line
end

def print_line(n=90)
  puts '-' * n
end

def print_table_header
  if @students.count > 0
    $stdout.print 'No. '
    @students.first.keys.each do |key|
      $stdout.print key.to_s.capitalize.center(@max_chars[key])
    end
    puts
    print_line
  end
end

# Find a maximum character count in students names, hobies, etc.
# for printing a flexible table of students data.
def find_max_chars
  @students.each do |student|
    student.each do |k, v|
      key_length = k.to_s.length
      value_length = ((v.is_a? Array) ? v.join(', ') : v.to_s).length
      current_max = (key_length > value_length ? key_length : value_length) + 2
      if (@max_chars[k] == nil) || (current_max > @max_chars[k])
        @max_chars[k] = current_max
      end
    end
  end
end

# selecting students by given arguments (first letter, name length)
def select_by_arguments(students, args)
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
  students
end

def print_students(students)
  i = 0
  while students.count > 0
    student = students.shift
    i += 1
    $stdout.print "#{i}. ".ljust(4)
    # print students hobbies, country, height, etc
    @max_chars.keys.each do |k|
      v = student[k]
      $stdout.print (v.is_a?(Array)? v.join(', ') : v).to_s.center(@max_chars[k])
    end
    puts
  end
end

def print_students_by_cohorts
  cohorts = []
  @students.each do |student|
    cohorts << student[:cohort] if !cohorts.include?(student[:cohort])
  end
  cohorts.each do |cohort|
    cohort_students = @students.select { |student| student[:cohort] == cohort }
    print_students(cohort_students)
    puts if cohort != cohorts.last
  end
end

def print_students_list(args = {})
  @students = select_by_arguments(@students, args)
  find_max_chars
  print_table_header
  print_students_by_cohorts
  print_line
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{'s' if @students.count>1}"
  puts
end

def get_student_name
  puts "Enter the name of student No.#{@students.count+1} (or hit return to finish)"
  gets.delete("\r\n").strip
end

def get_student_cohort
  puts "Enter student's cohort:"
  cohort = gets.delete("\r\n").strip.downcase
  cohort = (cohort == '') ? :november : cohort.to_sym
end

def get_student_hobbies
  hobbies = []
  puts "Enter student's hobbies: (to finish, hit return twice)"
  hobby = gets.delete("\r\n").strip
  while !hobby.empty? do
    hobbies << hobby
    hobby = gets.delete("\r\n").strip
  end
  hobbies
end

def get_student_country
  puts "Enter student's country:"
  gets.delete("\r\n").strip.capitalize
end

def get_student_height
  puts "Enter student's height:"
  gets.delete("\r\n").strip
end

def input_students
  puts
  name = get_student_name

  while !name.empty? do
    cohort  = get_student_cohort
    hobbies = get_student_hobbies
    country = get_student_country
    height  = get_student_height

    @students << {  name:    name,    cohort: cohort,
                    hobbies: hobbies, height: height,
                    country: country                    }

    puts "Now we have #{@students.count} student#{'s' if @students.count>1}\n\n"
    name = get_student_name
  end
end

def show_students
  if @students.count > 0 # dont print empty list
    print_header
    print_students_list({name_length: 30})
    print_footer
  else
    puts "No students..\n\n"
  end
end

def print_menu
  print_line
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp.strip)
  end
end

######## PROGRAM ########
interactive_menu
