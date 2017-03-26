class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :teacher_id
      t.integer :student_id
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
