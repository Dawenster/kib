class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include ServerMethods

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_PROGRAMS = ["1Y", "2Y", "MMM", "JD MBA", "Part-time", "EMBA", "Other"]
  VALID_YEAR_START = Time.current.year - 1
  VALID_YEAR_END = VALID_YEAR_START + 9
  VALID_YEARS = (VALID_YEAR_START..VALID_YEAR_END).to_a.map(&:to_s)

  REQUEST_RATIO_LIMIT = 2
  REQUEST_RATIO_EXPLANATION = "You must teach 1 class for every #{REQUEST_RATIO_LIMIT} #{'class'.pluralize(REQUEST_RATIO_LIMIT)} you take. " \
                              "Users with ratios greater than or equal to #{REQUEST_RATIO_LIMIT} can only request to be teachers (until their ratio falls)."

  ASSIGNMENT_RATIO_LIMIT = 2
  ASSIGNMENT_RATIO_EXPLANATION = "You must teach 1 class for every #{ASSIGNMENT_RATIO_LIMIT} #{'class'.pluralize(ASSIGNMENT_RATIO_LIMIT)} you take. " \
                                 "Users with ratios greater than or equal to #{ASSIGNMENT_RATIO_LIMIT} can only request to be teachers (until their ratio falls)."

  KELLOGG_DOMAIN = "kellogg.northwestern.edu"

  validates :first_name, :last_name, :program, :graduation_year, presence: true
  validates_inclusion_of :program, :in => VALID_PROGRAMS, message: "must be selected"
  validates_inclusion_of :graduation_year, :in => VALID_YEARS, message: "must be between #{VALID_YEAR_START} and #{VALID_YEAR_END}"
  validate :kellogg_email, unless: :should_not_validate_kellogg?

  scope :admin, -> { where(admin: true) }
  scope :assignable, -> { where(assignable: true) }
  scope :not_assignable, -> { where.not(assignable: true) }

  has_many :student_requests, class_name: 'Request', foreign_key: :student_id
  has_many :teacher_requests, class_name: 'Request', foreign_key: :teacher_id

  has_many :courses_as_student, class_name: 'Course', through: :student_requests, source: :course
  has_many :courses_as_teacher, class_name: 'Course', through: :teacher_requests, source: :course

  has_many :assigned_student_requests, -> { assigned }, class_name: 'Request', foreign_key: :student_id, dependent: :delete_all
  has_many :assigned_teacher_requests, -> { assigned }, class_name: 'Request', foreign_key: :teacher_id, dependent: :delete_all
  has_many :unassigned_student_requests, -> { unassigned }, class_name: 'Request', foreign_key: :student_id, dependent: :delete_all
  has_many :unassigned_teacher_requests, -> { unassigned }, class_name: 'Request', foreign_key: :teacher_id, dependent: :delete_all

  has_many :assigned_courses_as_student, class_name: 'Course', through: :assigned_student_requests, source: :course
  has_many :assigned_courses_as_teacher, class_name: 'Course', through: :assigned_teacher_requests, source: :course
  has_many :unassigned_courses_as_student, class_name: 'Course', through: :unassigned_student_requests, source: :course
  has_many :unassigned_courses_as_teacher, class_name: 'Course', through: :unassigned_teacher_requests, source: :course

  has_many :assigned_seminars_as_student, class_name: 'Seminar', through: :assigned_student_requests, source: :seminar
  has_many :assigned_seminars_as_teacher, class_name: 'Seminar', through: :assigned_teacher_requests, source: :seminar

  def is_admin?
    !!admin
  end

  def not_admin?
    !is_admin?
  end

  def should_not_validate_kellogg?
    is_admin? || !Rails.env.production?
  end

  def name # For rails admin
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def program_and_year
    "#{program}, #{graduation_year}"
  end

  def all_requests
    Request.where(id: student_requests.pluck(:id) + teacher_requests.pluck(:id))
  end

  def request_ratio(num_student_requests_to_add = 0, num_teacher_requests_to_remove = 0)
    num_teacher_requests = teacher_requests.count.to_f - num_teacher_requests_to_remove
    num_student_requests = student_requests.count + num_student_requests_to_add
    if num_teacher_requests == 0.0
      num_student_requests
    else
      num_student_requests / num_teacher_requests
    end
  end

  def request_ratio_for_display
    ('%.2f' % request_ratio).to_f
  end

  def above_request_ratio_threshold?(num_student_requests_to_add = 0, num_teacher_requests_to_remove = 0)
    request_ratio(num_student_requests_to_add, num_teacher_requests_to_remove) > REQUEST_RATIO_LIMIT
  end

  def assignment_ratio(num_student_requests_to_add = 0, num_teacher_requests_to_remove = 0)
    num_times_assigned_as_teacher = teacher_requests.assigned.count.to_f - num_teacher_requests_to_remove
    num_times_assigned_as_student = student_requests.assigned.count + num_student_requests_to_add
    if num_times_assigned_as_teacher == 0.0 && num_times_assigned_as_student <= 1 # Only allow first time without teaching
      num_times_assigned_as_student
    else
      num_times_assigned_as_student / num_times_assigned_as_teacher
    end
  end

  def assignment_ratio_for_display
    if assignment_ratio == Float::INFINITY
      "Infinite"
    else
      ('%.2f' % assignment_ratio).to_f
    end
  end

  def above_assignment_ratio_threshold?(num_student_requests_to_add = 0, num_teacher_requests_to_remove = 0)
    assignment_ratio(num_student_requests_to_add, num_teacher_requests_to_remove) > ASSIGNMENT_RATIO_LIMIT
  end

  def can_send_email?
    kib_production? || is_admin?
  end

  private

  def kellogg_email
    email_domain = email.split("@").last
    errors.add(:email, "must end in @#{KELLOGG_DOMAIN}") if email_domain.try(:downcase).try(:strip) != KELLOGG_DOMAIN
  end

end
