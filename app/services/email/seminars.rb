class Email::Seminars

  def initialize(seminar)
    @seminar = seminar
  end

  def notify_all_students_of_finalized_assignment
    @seminar.students.each do |student|
      begin
        SeminarMailer.seminar_assigned_as_student(student, @seminar).deliver_now
      rescue => e
        Rollbar.error(e, student_id: student.try(:id))
      end
    end
  end

  def notify_teacher_of_finalized_assignment
    teacher = @seminar.teacher
    begin
      SeminarMailer.seminar_assigned_as_teacher(teacher, @seminar).deliver_now
    rescue => e
      Rollbar.error(e, teacher_id: teacher.try(:id))
    end
  end

end