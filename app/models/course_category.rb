class CourseCategory < ActiveRecord::Base
  
  validates :code, :name, presence: true

end