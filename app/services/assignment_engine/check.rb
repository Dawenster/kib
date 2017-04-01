class AssignmentEngine::Check

  attr_reader :course
  attr_reader :num_teachers_that_can_take_course
  attr_reader :num_students_that_can_take_course
  attr_reader :pass

  MIN_REQUIRED_TEACHERS = 1
  MIN_REQUIRED_STUDENTS = 3

  def initialize(course)
    @course = course
    @num_teachers_that_can_take_course = @course.teachers_who_can_be_assigned.count
    @num_students_that_can_take_course = @course.students_who_can_be_assigned.count
    @pass = false
  end

  def seminar_creation
    @pass = true if can_schedule?
    return self
  end

  def can_schedule?
    enough_teachers? || enough_students?
  end

  def enough_teachers?
    @num_teachers_that_can_take_course >= MIN_REQUIRED_TEACHERS
  end

  def enough_students?
    @num_students_that_can_take_course >= MIN_REQUIRED_STUDENTS
  end

end