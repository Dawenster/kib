class Email::Seminars

  FREQUENCY_OF_CHECK_IN_DAYS = 2

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
      if seminar.should_be_completed? && correct_frequency_of_send?(seminar)
        teacher = seminar.teacher
        begin
          SeminarMailer.ask_if_seminar_complete(teacher, seminar).deliver_now
        rescue => e
          Rollbar.error(e, seminar_id: seminar.try(:id))
        end
      end
    end
  end

  def notify_students_to_leave_review
    @seminar.students.each do |student|
      begin
        SeminarMailer.ask_student_for_review(student, @seminar).deliver_now
      rescue => e
        Rollbar.error(e, student_id: student.try(:id))
      end
    end
  end

  def self.correct_frequency_of_send?(seminar)
    days_since_seminar_scheduled_at(seminar) % FREQUENCY_OF_CHECK_IN_DAYS == 0
  end

  def self.days_since_seminar_scheduled_at(seminar)
    (Time.current.to_date - seminar.scheduled_at.to_date).to_i
  end

end