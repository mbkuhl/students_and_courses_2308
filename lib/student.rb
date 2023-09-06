class Student
  attr_reader :name, :age, :scores
  def initialize(student_hash)
    @name = student_hash[:name]
    @age = student_hash[:age]
    @scores = []
  end

  def log_score(score)
    @scores << score
  end

  def grade
    f_scores = @scores.map { |score| score.to_f }
    num_scores = scores.count.to_f
    sum_scores = f_scores.sum
    sum_scores / num_scores
  end
end
