class AssignmentEngine::Check

  attr_reader :pass

  MIN_REQUIRED_TEACHERS = 1
  MIN_REQUIRED_STUDENTS = 3

  def initialize(course)
    @course
    @teacher_requests = @course.requests.unassigned.teacher
    @student_requests = @course.requests.unassigned.student
    @pass = false
  end

  def seminar_creation
    @pass = true unless should_not_schedule?
    return self
  end

  def should_not_schedule?
    not_enough_teachers? || not_enough_students?
  end

  def not_enough_teachers?
    @teacher_requests.count < MIN_REQUIRED_TEACHERS
  end

  def not_enough_students?
    @student_requests.count < MIN_REQUIRED_STUDENTS
  end

end