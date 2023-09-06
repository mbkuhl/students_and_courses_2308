class GradeBook
  attr_reader :instructor, :courses
  def initialize(instructor)
    @instructor = instructor
    @courses = []
  end

  def add_course(course)
    @courses << course
  end

  def list_all_students
    students_by_course = Hash.new(nil)
    @courses.each do |course|
      students_by_course[course] = course.students
    end
    students_by_course
  end

  def students_below(grade)
    students_below_grade = []
    @courses.each do |course|
      course.students.each do |student|
        if student.grade < grade
          students_below_grade << student
        end
      end
    end
    students_below_grade.uniq
  end

  def all_grades
    grades_by_course = Hash.new(nil)
    @courses.each do |course|
      grades = course.students.map { |student| student.grade }
      grades_by_course[course] = grades
    end
    grades_by_course
  end

  def students_in_range(min, max)
    students_within_range = []
    @courses.each do |course|
      course.students.each do |student|
        if student.grade > min && student.grade < max
          students_within_range << student
        end
      end
    end
    students_within_range.uniq
  end

end