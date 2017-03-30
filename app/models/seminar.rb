class Seminar < ActiveRecord::Base

  belongs_to :course

  has_many :requests

  has_and_belongs_to_many :students,
                          :class_name => 'User',
                          :join_table => :requests,
                          :foreign_key => :seminar_id,
                          :association_foreign_key => :student_id

  has_and_belongs_to_many :teachers,
                          :class_name => 'User',
                          :join_table => :requests,
                          :foreign_key => :seminar_id,
                          :association_foreign_key => :teacher_id

  DEFAULT_DURATION_IN_MIN = 60

end
