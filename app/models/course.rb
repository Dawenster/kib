class Course < ActiveRecord::Base
  
  validates :code, :name, presence: true

  scope :active, -> { where(active: true) }

  belongs_to :course_category

  has_many :requests

  has_and_belongs_to_many :requesting_students,
                          :class_name => 'User',
                          :join_table => :requests,
                          :foreign_key => :course_id,
                          :association_foreign_key => :student_id

  has_and_belongs_to_many :requesting_teachers,
                          :class_name => 'User',
                          :join_table => :requests,
                          :foreign_key => :course_id,
                          :association_foreign_key => :teacher_id

  def student_requests
    requests.where.not(student_id: nil)
  end

  def teacher_requests
    requests.where.not(teacher_id: nil)
  end

end
