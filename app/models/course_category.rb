class CourseCategory < ActiveRecord::Base
  
  validates :code, :name, presence: true
  validates :code, :name, uniqueness: true

  has_many :courses


end