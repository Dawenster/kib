class AddAssignableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :assignable, :boolean, default: true
  end
end
