class AddClassIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :class_id, :integer
  end
end
