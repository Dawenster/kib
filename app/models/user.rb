class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_PROGRAMS = ["1Y", "2Y", "MMM", "JD MBA", "Part-time", "EMBA", "Other"]
  VALID_YEAR_START = Time.current.year - 1
  VALID_YEAR_END = VALID_YEAR_START + 9
  VALID_YEARS = (VALID_YEAR_START..VALID_YEAR_END).to_a.map(&:to_s)

  SEMINAR_RATIO_LIMIT = 2
  SEMINAR_RATIO_EXPLANATION = "You must teach 1 class for every #{SEMINAR_RATIO_LIMIT} classes you take. " \
                              "Users with ratios greater than #{SEMINAR_RATIO_LIMIT} can only request to be teachers (until their ratio falls). " \
                              "You can take your first class without being a teacher, " \
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

  def seminar_ratio
    num_times_taught = teacher_requests.count.to_f
    num_times_as_student = student_requests.count
    if num_times_as_student == 0
      0
    elsif num_times_taught == 0
      1 / 0.0
    else
      ('%.2f' % (num_times_as_student / num_times_taught)).to_f
    end
  end

  def seminar_ratio_for_display
    if seminar_ratio == Float::INFINITY
      "Infinite (please teach a course)"
    else
      seminar_ratio
    end
  end

  def above_seminar_ratio_threshold
    seminar_ratio >= SEMINAR_RATIO_LIMIT
  end

end
