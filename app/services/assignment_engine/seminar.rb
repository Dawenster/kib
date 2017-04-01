class AssignmentEngine::Seminar

  attr_reader :course
  attr_reader :seminar

  MAX_STUDENTS_ALLOWED_IN_SEMINAR = 5

  def initialize(args)
    @course = args[:course]
    @teacher = args[:teacher]
    @seminar = nil
  end

  def create
    @seminar = Seminar.create(duration_in_min: Seminar::DEFAULT_DURATION_IN_MIN)
    assign_teacher
    assign_students
    raise @seminar.errors.full_messages unless @seminar.save
  end

  def assign_teacher
    @seminar.teacher = @teacher
  end

  def assign_students
    students = AssignmentEngine::Student.ordered_by_classes_taken(@course)
    students.first(MAX_STUDENTS_ALLOWED_IN_SEMINAR).each do |student|
      assign_student(student)
    end
  end

  def assign_student(student)
    request = Request.unassigned.where(student: student, course: course).first
    raise if request.nil?

    request.seminar = @seminar
    request.assigned = true
    request.save
  end

end