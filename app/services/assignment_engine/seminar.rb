class AssignmentEngine::Seminar

  attr_reader :course
  attr_reader :teacher
  attr_reader :seminar

  MAX_STUDENTS_ALLOWED_IN_SEMINAR = 5

  def initialize(args)
    @course = args[:course]
    @teacher = args[:teacher]
    @seminar = nil
  end

  def create
    create_seminar_with_default_duration
    assign_teacher
    assign_students
    raise @seminar.errors.full_messages unless @seminar.save
  end

  def create_seminar_with_default_duration
    @seminar = ::Seminar.create(duration_in_min: ::Seminar::DEFAULT_DURATION_IN_MIN)
  end

  def assign_teacher
    @teacher.unassigned_teacher_requests.where(course: @course).update_all(
      seminar_id: @seminar.id,
      assigned: true
    )
  end

  def assign_students
    students = AssignmentEngine::Student.ordered_by_classes_taken(@course)
    students.first(MAX_STUDENTS_ALLOWED_IN_SEMINAR).each do |student|
      assign_student(student)
    end
  end

  def assign_student(student)
    request = ::Request.unassigned.where(student: student, course: @course).first
    raise "Request not found" if request.nil?

    request.seminar = @seminar
    request.assigned = true
    request.save
  rescue => e
    Rollbar.error(e, student_id: student.id)
  end

end