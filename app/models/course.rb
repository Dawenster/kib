class Course < ActiveRecord::Base
  
  validates :code, :name, presence: true

  scope :active, -> { where(active: true) }

  belongs_to :course_category

  has_many :requests

  has_many :assigned_requests, -> { assigned }, class_name: 'Request', foreign_key: :course_id, dependent: :delete_all
  has_many :unassigned_requests, -> { unassigned }, class_name: 'Request', foreign_key: :course_id, dependent: :delete_all

  has_many :assigned_requesting_students, class_name: 'User', through: :assigned_requests, source: :student
  has_many :unassigned_requesting_students, class_name: 'User', through: :unassigned_requests, source: :student

  def code_and_name
    "#{code} - #{name}"
  end

  def student_requests
    requests.where.not(student_id: nil)
  end

  def teacher_requests
    requests.where.not(teacher_id: nil)
  end

end
