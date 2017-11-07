class Student
  attr_reader :first_name, :last_name, :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{first_name} #{last_name}"
  end

  def enroll(course)
    if courses.any? { |co| co.conflicts_with?(course) }
      raise "Cannot enroll in course: there is a conflict."
    elsif !course.students.include?(name) && !courses.include?(course)
      @courses << course
      course.students << self
    end
  end

  # @return [Hash{String => Number}] departments to student's number of credits in each
  def course_load
    courses.reduce(Hash.new(0)) do |depts_credits, course|
      depts_credits[course.department] += course.credits
      depts_credits
    end
  end
end
