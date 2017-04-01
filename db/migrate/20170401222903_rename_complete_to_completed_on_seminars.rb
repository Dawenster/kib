class RenameCompleteToCompletedOnSeminars < ActiveRecord::Migration
  def change
    rename_column :seminars, :complete, :completed
  end
end
