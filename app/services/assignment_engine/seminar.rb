class AssignmentEngine::Seminar

  attr_reader :course
  attr_reader :seminar

  def initialize(args)
    @course = args[:course]
    @teacher = args[:teacher]
    @seminar = nil
  end

  def create
    @seminar = Seminar.create(duration_in_min: Seminar::DEFAULT_DURATION_IN_MIN)
    assign_teacher
    assign_students
    mark_requests_as_assigned
  end

  def assign_teacher
    @seminar.teacher = @teacher
  end

  def assign_students
    
  end

  def mark_requests_as_assigned
    
  end

end