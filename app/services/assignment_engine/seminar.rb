class AssignmentEngine::Seminar

  attr_reader :course
  attr_reader :seminar

  def initialize(course_id)
    @course = Course.find(course_id)
    @seminar = nil
  end

  def create
    @seminar = Seminar.create(duration_in_min: Seminar::DEFAULT_DURATION_IN_MIN)
    assign_teacher
    assign_students
    mark_requests_as_assigned
  end

  def assign_teacher
    @course
  end

  def assign_students
    
  end

  def mark_requests_as_assigned
    
  end

end