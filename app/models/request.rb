class Request < ActiveRecord::Base

  validate :exactly_one_request_type
  validate :user_within_ratio_limits, on: :create

  scope :assigned, -> { where(assigned: true) }
  scope :unassigned, -> { where.not(assigned: true) }
  scope :student, -> { where.not(student_id: nil) }
  scope :teacher, -> { where.not(teacher_id: nil) }

  belongs_to :student, class_name: "User", foreign_key: :student_id
  belongs_to :teacher, class_name: "User", foreign_key: :teacher_id
  belongs_to :course
  belongs_to :seminar

  before_destroy :user_within_ratio_limits_check_on_destroy

  STATUSES = [
    PENDING_ASSIGNMENT = "pending_assignment",
    PENDING_FINALIZATION = "pending_finalization",
    ASSIGNED = "assigned",
    COMPLETED = "completed"
  ]

  def role
    return "student" if student_id.present?
    return "teacher" if teacher_id.present?
  end

  def assigned?
    assigned
  end

  def assigned_and_finalized?
    assigned && seminar.present? && seminar.finalized?
  end

  def assigned_and_not_finalized?
    assigned && seminar.present? && seminar.not_finalized?
  end

  def assigned_and_completed?
    assigned && seminar.present? && seminar.completed?
  end

  def name
    owner.try(:full_name)
  end

  def owner
    User.find_by_id(student_id || teacher_id)
  end

  def status
    if assigned_and_completed?
      snake_cased_status = COMPLETED
    elsif assigned_and_finalized?
      snake_cased_status = ASSIGNED
    elsif assigned
      snake_cased_status = PENDING_FINALIZATION
    else
      snake_cased_status = PENDING_ASSIGNMENT
    end
    snake_cased_status.humanize
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
      errors.add(:base, "Assignment ratio too high")
      false
    elsif user.above_request_ratio_threshold?(num_student_requests_to_add, num_teacher_requests_to_remove)
      errors.add(:base, "Request ratio too high")
      false
    end
  end

  def user_within_ratio_limits_check_on_destroy
    user_within_ratio_limits(true)
  end

end
