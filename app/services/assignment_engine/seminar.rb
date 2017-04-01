class AssignmentEngine::Seminar

  attr_reader :course

  def initialize(course_id)
    @course = Course.find(course_id)
  end

  def create

  end

end