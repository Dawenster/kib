class CreateCourseCategories < ActiveRecord::Migration
  def change
    create_table :course_categories do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
