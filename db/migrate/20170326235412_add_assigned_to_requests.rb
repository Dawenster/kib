class AddAssignedToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :assigned, :boolean, default: false
  end
end
