class CreateClasses < ActiveRecord::Migration
  def change
    create_table :classes do |t|
      t.datetime :scheduled_at
      t.string :location
      t.text :description

      t.timestamps null: false
    end
  end
end
