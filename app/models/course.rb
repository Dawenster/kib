class Course < ActiveRecord::Base
  
  validates :code, :name, presence: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where.not(active: true) }

  belongs_to :course_category

  has_many :requests

  has_many :assigned_requests, -> { assigned }, class_name: 'Request', foreign_key: :course_id, dependent: :delete_all
  has_many :unassigned_requests, -> { unassigned }, class_name: 'Request', foreign_key: :course_id, dependent: :delete_all

  has_many :assigned_requesting_students, class_name: 'User', through: :assigned_requests, source: :student
  has_many :assigned_requesting_teachers, class_name: 'User', through: :assigned_requests, source: :teacher
  has_many :unassigned_requesting_students, class_name: 'User', through: :unassigned_requests, source: :student
  has_many :unassigned_requesting_teachers, class_name: 'User', through: :unassigned_requests, source: :teacher

  def code_and_name
    "#{code} - #{name}"
  end

  def student_requests
    requests.where.not(student_id: nil)
  end

  def teacher_requests
    requests.where.not(teacher_id: nil)
  end

  def students_who_can_be_assigned
    unassigned_requesting_students.assignable.select do |student|
      !student.above_assignment_ratio_threshold?(1, 0) # Putting 1 here because we're "adding" an assigned request
    end
  end

  def teachers_who_can_be_assigned
    unassigned_requesting_teachers.assignable.select do |teacher|
      !teacher.above_assignment_ratio_threshold?
    end
  end

end
