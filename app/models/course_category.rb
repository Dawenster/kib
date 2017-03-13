class CourseCategory < ActiveRecord::Base
  
  validates :code, :name, presence: true

  has_many :courses

end