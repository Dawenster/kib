namespace :course_categories do
  desc "Create initial list of course categories"
  task create_initial_list: :environment do
    course_category_arrays.each do |course_category_array|
      cc = CourseCategory.create(
        code: course_category_array[0],
        name: course_category_array[1]
      )
      courses = Course.where("code like ?", "%#{cc.code}%")
      courses.update_all(course_category_id: cc.id)
      puts "#{cc.code} created"
    end
  end

  def course_category_arrays
    [
      ["ACCT", "Accounting"],
      ["BLAW", "Business Law"],
      ["DECS", "Decision Sciences"],
      ["FINC", "Finance"],
      ["HEMA", "Health Enterprise Management"],
      ["INTL", "International Studies"],
      ["KACI", "Architectures of Collaboration"],
      ["KIEI", "Innovation & Entrepreneurship"],
      ["KMCI", "Markets & Customers"],
      ["KPPI", "Public-Private Interface"],
      ["MECN", "Managerial Economics"],
      ["MECS", "Managerial Economics & Strategy"],
      ["MEDM", "Media Management"],
      ["MKTG", "Marketing"],
      ["MORS", "Management & Organizations"],
      ["OPNS", "Operations Management"],
      ["REAL", "Real Estate"],
      ["STRT", "Business Strategy"]
    ]
  end
end
