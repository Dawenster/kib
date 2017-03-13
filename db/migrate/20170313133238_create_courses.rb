class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
