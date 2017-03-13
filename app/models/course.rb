class Course < ActiveRecord::Base
  
  validates :code, :name, presence: true

end
