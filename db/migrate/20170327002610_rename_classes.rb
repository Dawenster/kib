class RenameClasses < ActiveRecord::Migration
  def change
    rename_table :classes, :seminars
  end
end
