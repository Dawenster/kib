class Request < ActiveRecord::Base

  validate :exactly_one_request_type

  belongs_to :student, class_name: "User", foreign_key: :student_id
  belongs_to :teacher, class_name: "User", foreign_key: :teacher_id
  belongs_to :course
  belongs_to :seminar

  def role
    return "student" if student_id.present?
    return "teacher" if teacher_id.present?
  end

  private

  def exactly_one_request_type
    if student_id.nil? && teacher_id.nil?
      errors.add(:base, "Must request as either student or teacher")
    end

    if student_id.present? && teacher_id.present?
      errors.add(:base, "Must request as either student or teacher, not both")
    end
  end

end
