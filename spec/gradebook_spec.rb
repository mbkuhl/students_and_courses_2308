require 'rspec'
require './spec/spec_helper'

RSpec.describe GradeBook do
  before (:each) do
    @course1 = Course.new("Calculus", 2)
    @course2 = Course.new("History", 3)
    @student1 = Student.new({name: "Morgan", age: 21})
    @student2 = Student.new({name: "Jordan", age: 29})
    @student3 = Student.new({name: "Jeffrey", age: 35})
    @student4 = Student.new({name: "Wilt", age: 45})
    @course1.enroll(@student1)
    @course1.enroll(@student2)
    @course2.enroll(@student3)
    @course2.enroll(@student4)
    @course2.enroll(@student1)
    @gradebook = GradeBook.new("Herman")
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@gradebook).to be_a(GradeBook)
      expect(@gradebook.instructor).to eq("Herman")
      expect(@gradebook.courses).to eq([])
    end
  end

  describe '#add_course' do
    it 'can add courses to a gradebook' do
      expect(@gradebook.add_course(@course1)).to eq([@course1])
      expect(@gradebook.courses).to eq([@course1])
      expect(@gradebook.add_course(@course2)).to eq([@course1, @course2])
      expect(@gradebook.courses).to eq([@course1, @course2])
    end
  end

  describe '#list_all_students' do
    it 'can list all students in a hash by keys of courses' do
      @gradebook.add_course(@course1)
      @gradebook.add_course(@course2)
      expect(@gradebook.list_all_students).to eq({
        @course1 => [@student1, @student2],
        @course2 => [@student3, @student4, @student1]
      })
    end
  end

  describe '#students_below' do
    it 'can list all students below a threshhold grade' do
      @gradebook.add_course(@course1)
      @gradebook.add_course(@course2)
      @student1.log_score(50)
      @student1.log_score(45)
      @student2.log_score(90)
      @student2.log_score(90)
      @student3.log_score(80)
      @student3.log_score(90)
      @student4.log_score(91)
      @student4.log_score(1)
      @student4.log_score(2)
      expect(@gradebook.students_below(10)).to eq([])
      expect(@gradebook.students_below(60)).to eq([@student1, @student4])
    end
  end

  describe '#all_grades' do
    it 'can list all grades in a hash sorted by course' do
      @gradebook.add_course(@course1)
      @gradebook.add_course(@course2)
      @student1.log_score(50)
      @student1.log_score(45)
      @student2.log_score(90)
      @student2.log_score(90)
      @student3.log_score(80)
      @student3.log_score(90)
      @student4.log_score(91)
      @student4.log_score(1)
      @student4.log_score(2)
      expect(@gradebook.all_grades).to eq({
        @course1 => [@student1.grade, @student2.grade],
        @course2 => [@student3.grade, @student4.grade, @student1.grade]
      })
    end
  end

  describe '#students_in_range' do
    it 'can list all students in between two numbers' do
      @gradebook.add_course(@course1)
      @gradebook.add_course(@course2)
      @student1.log_score(50)
      @student1.log_score(45)
      @student2.log_score(90)
      @student2.log_score(90)
      @student3.log_score(80)
      @student3.log_score(90)
      @student4.log_score(91)
      @student4.log_score(1)
      @student4.log_score(2)
      expect(@gradebook.students_in range(10-50)).to eq([@student1, @student4])
      expect(@gradebook.students_below(60-89)).to eq([@student3])
      expect(@gradebook.students_below(60-91)).to eq([@student2, @student3])
    end
  end
end