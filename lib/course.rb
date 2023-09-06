class Course
  attr_reader :name, :capacity, :students
  def initialize(name, capacity)
    @name = name
    @capacity = capacity
    @students = []
    @full = false
  end

  def full?
    if @students.count < @capacity
      @full = false
    else
      @full = true
    end
  end
  
  def enroll(student)
    if @full == false
      @students << student
    end
  end
end
