class AddCourseCategoryIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_category_id, :integer
  end
end
