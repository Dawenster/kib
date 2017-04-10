class AddDropboxColumnsToSeminars < ActiveRecord::Migration
  def change
    add_column :seminars, :dropbox_folder_path, :string
    add_column :seminars, :dropbox_url, :string
  end
end
