class Request < ActiveRecord::Base

  validate :exactly_one_request_type
  validate :user_within_ratio_limits, on: :create, if: :check_ratios

  scope :assigned, -> { where(assigned: true) }
  scope :unassigned, -> { where.not(assigned: true) }
  scope :student, -> { where.not(student_id: nil) }
  scope :teacher, -> { where.not(teacher_id: nil) }

  belongs_to :student, class_name: "User", foreign_key: :student_id
  belongs_to :teacher, class_name: "User", foreign_key: :teacher_id
  belongs_to :course
  belongs_to :seminar

  before_destroy :user_within_ratio_limits_check_on_destroy

  def role
    return "student" if student_id.present?
    return "teacher" if teacher_id.present?
  end

  def assigned?
    assigned
  end

  private

  def check_ratios
    !Rails.env.test?
  end

  def exactly_one_request_type
    if student_id.nil? && teacher_id.nil?
      errors.add(:base, "Must request as either student or teacher")
    end

    if student_id.present? && teacher_id.present?
      errors.add(:base, "Must request as either student or teacher, not both")
    end
  end

  def user_within_ratio_limits(from_destroy = false)
    # On destroy, only checking if destroying a teaching request
    if from_destroy
      return true if !teacher_id.present?
      num_student_requests_to_add, num_teacher_requests_to_remove = 0, 1
    else
      return true if teacher_id.present?
      num_student_requests_to_add, num_teacher_requests_to_remove = 1, 0
    end

    user = User.find(student_id || teacher_id)
    if assigned? && user.above_assignment_ratio_threshold?(num_student_requests_to_add, num_teacher_requests_to_remove)
      errors.add(:base, "Cannot go above assignment threshold")
      false
    elsif user.above_request_ratio_threshold?(num_student_requests_to_add, num_teacher_requests_to_remove)
      errors.add(:base, "Cannot go above request threshold")
      false
    end
  end

  def user_within_ratio_limits_check_on_destroy
    user_within_ratio_limits(true)
  end

end
