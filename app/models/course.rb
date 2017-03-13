class Course < ActiveRecord::Base
  
  validates :code, :name, presence: true

  scope :active, -> { where(active: true) }
end
