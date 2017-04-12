class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :seminar_id
      t.integer :rating
      t.text :feedback_for_teacher
      t.text :feedback_for_kib

      t.timestamps null: false
    end
  end
end
