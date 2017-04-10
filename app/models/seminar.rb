class Seminar < ActiveRecord::Base

  validates :dropbox_folder_path, :dropbox_url, uniqueness: true

  scope :finalized, -> { where(finalized: true) }
  scope :not_finalized, -> { where.not(finalized: true) }
  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where.not(completed: true) }

  belongs_to :course

  has_many :requests

  has_many :assigned_requests, -> { assigned }, class_name: 'Request', foreign_key: :seminar_id
  has_many :assigned_requesting_students, class_name: 'User', through: :assigned_requests, source: :student
  has_many :assigned_requesting_teachers, class_name: 'User', through: :assigned_requests, source: :teacher

  DEFAULT_DURATION_IN_MIN = 60

  def teacher
    assigned_requesting_teachers.first
  end

  def students
    assigned_requesting_students
  end

  def finalized?
    finalized
  end

  def completed?
    completed
  end

end
