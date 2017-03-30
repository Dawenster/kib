class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_PROGRAMS = ["1Y", "2Y", "MMM", "JD MBA", "Part-time", "EMBA", "Other"]
  VALID_YEAR_START = Time.current.year - 1
  VALID_YEAR_END = VALID_YEAR_START + 9
  VALID_YEARS = (VALID_YEAR_START..VALID_YEAR_END).to_a.map(&:to_s)

  REQUEST_RATIO_LIMIT = 2
  REQUEST_RATIO_EXPLANATION = "You must request to teach 1 class for every #{REQUEST_RATIO_LIMIT} #{'request'.pluralize(REQUEST_RATIO_LIMIT)} to learn."

  ASSIGNMENT_RATIO_LIMIT = 2
  ASSIGNMENT_RATIO_EXPLANATION = "You can only be assigned #{ASSIGNMENT_RATIO_LIMIT} #{'class'.pluralize(ASSIGNMENT_RATIO_LIMIT)} for every 1 class you teach. " \
                                 "Users with ratios greater than #{ASSIGNMENT_RATIO_LIMIT} can only assigned as teachers (until their ratio falls). " \
                                 "You can be assigned your first class without being a teacher, " \
                                 "but after that you will need to teach in order to keep taking classes."

  validates :first_name, :last_name, :program, :graduation_year, presence: true
  validates_inclusion_of :program, :in => VALID_PROGRAMS, message: "must be selected"
  validates_inclusion_of :graduation_year, :in => VALID_YEARS, message: "must be between #{VALID_YEAR_START} and #{VALID_YEAR_END}"

  has_many :student_requests, class_name: 'Request', foreign_key: :student_id
  has_many :teacher_requests, class_name: 'Request', foreign_key: :teacher_id

  has_and_belongs_to_many :requested_courses_as_student,
                          :class_name => 'Course',
                          :join_table => :requests,
                          :foreign_key => :student_id,
                          :association_foreign_key => :course_id

  has_and_belongs_to_many :requested_courses_as_teacher,
                          :class_name => 'Course',
                          :join_table => :requests,
                          :foreign_key => :teacher_id,
                          :association_foreign_key => :course_id

  has_and_belongs_to_many :seminars_as_student,
                          :class_name => 'Seminar',
                          :join_table => :requests,
                          :foreign_key => :student_id,
                          :association_foreign_key => :seminar_id

  has_and_belongs_to_many :seminars_as_teacher,
                          :class_name => 'Seminar',
                          :join_table => :requests,
                          :foreign_key => :teacher_id,
                          :association_foreign_key => :seminar_id

  def is_admin?
    !!admin
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def program_and_year
    "#{program}, #{graduation_year}"
  end

  def all_requests
    student_requests + teacher_requests
  end

  def request_ratio
    num_teacher_requests = teacher_requests.count.to_f
    num_student_requests = student_requests.count
    if num_teacher_requests == 0
      num_student_requests
    else
      num_student_requests / num_teacher_requests
    end
  end

  def request_ratio_for_display
    ('%.2f' % request_ratio).to_f
  end

  def above_request_ratio_threshold
    request_ratio >= REQUEST_RATIO_LIMIT
  end

  def assignment_ratio
    num_times_assigned_as_teacher = teacher_requests.assigned.count.to_f
    num_times_assigned_as_student = student_requests.assigned.count
    return 0 if num_times_assigned_as_student == 0
    num_times_assigned_as_student / num_times_assigned_as_teacher
  end

  def assignment_ratio_for_display
    if assignment_ratio == Float::INFINITY
      "Infinite"
    else
      ('%.2f' % assignment_ratio).to_f
    end
  end

  def above_assignment_ratio_threshold
    assignment_ratio >= ASSIGNMENT_RATIO_LIMIT
  end

end
