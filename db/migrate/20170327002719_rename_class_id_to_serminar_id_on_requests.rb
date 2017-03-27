class RenameClassIdToSerminarIdOnRequests < ActiveRecord::Migration
  def change
    rename_column :requests, :class_id, :seminar_id
  end
end
