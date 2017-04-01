class AddCompleteToSeminars < ActiveRecord::Migration
  def change
    add_column :seminars, :complete, :boolean, default: false
  end
end
