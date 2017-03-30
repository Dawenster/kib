class AddDurationInMinToSeminars < ActiveRecord::Migration
  def change
    add_column :seminars, :duration_in_min, :integer
  end
end
