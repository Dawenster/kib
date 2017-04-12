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

  def self.ask_teachers_if_seminars_completed
    Seminar.finalized.incomplete.each do |seminar|
      if seminar.should_be_completed?
        teacher = seminar.teacher
        SeminarMailer.ask_if_seminar_complete(teacher, seminar).deliver_now
      end
    end
  end

end