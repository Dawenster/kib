class Seminar < ActiveRecord::Base

  belongs_to :course

  has_many :requests

  has_many :assigned_requests, -> { assigned }, class_name: 'Request', foreign_key: :seminar_id, dependent: :delete_all
  has_many :assigned_requesting_students, class_name: 'User', through: :assigned_requests, source: :student

  DEFAULT_DURATION_IN_MIN = 60

end
