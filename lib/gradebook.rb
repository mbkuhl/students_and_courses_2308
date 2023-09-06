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

end