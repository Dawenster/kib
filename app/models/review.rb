class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :seminar
  belongs_to :teacher, class_name: User, foreign_key: "teacher_id"

  validates :rating, :feedback_for_teacher, :feedback_for_kib, :reason_for_taking_seminar, presence: true

  REASONS_FOR_TAKING_CLASS = [
    "Didn't have enough bid points",
    "Didn't want to spend too many bid points",
    "Using KiB to see if I'm going to take this class later",
    "Wanted to learn key concepts for my internship/full-time job",
    "Other"
  ]

  def value
    if reason_is_other?
      "Other"
    else
      reason_for_taking_seminar
    end
  end

  def other_value
    if reason_is_other?
      reason_for_taking_seminar[7..-1]
    else
      nil
    end
  end

  def reason_is_other?
    reason_for_taking_seminar.present? && reason_for_taking_seminar[0..4] == "Other"
  end

end
