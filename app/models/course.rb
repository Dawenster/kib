class Course < ActiveRecord::Base
  
  validates :code, :name, presence: true

  scope :active, -> { where(active: true) }

  belongs_to :course_category
end
