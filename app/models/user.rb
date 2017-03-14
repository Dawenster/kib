class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_PROGRAMS = ["1Y", "2Y", "MMM", "JD MBA", "Part-time", "EMBA", "Other"]
  VALID_YEAR_START = Time.current.year - 1
  VALID_YEAR_END = VALID_YEAR_START + 9
  VALID_YEARS = (VALID_YEAR_START..VALID_YEAR_END).to_a.map(&:to_s)

  validates :first_name, :last_name, :program, :graduation_year, presence: true
  validates_inclusion_of :program, :in => VALID_PROGRAMS, message: "must be selected"
  validates_inclusion_of :graduation_year, :in => VALID_YEARS, message: "must be between #{VALID_YEAR_START} and #{VALID_YEAR_END}"

  def full_name
    "#{first_name} #{last_name}"
  end
end
