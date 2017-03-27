class AddCourseIdToClasses < ActiveRecord::Migration
  def change
    add_column :classes, :course_id, :integer
  end
end
