class AddFinalizedToSeminars < ActiveRecord::Migration
  def change
    add_column :seminars, :finalized, :boolean, default: false
  end
end
