class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :seminar
  belongs_to :teacher, class_name: User, foreign_key: "teacher_id"

end
