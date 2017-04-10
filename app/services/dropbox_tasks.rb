class DropboxTasks
  
  require 'dropbox_sdk'

  def initialize  
    @client = ::DropboxClient.new(ENV["DROPBOX_ACCESS_TOKEN"])
  end

  def create_folder(path)
    @client.file_create_folder(path)
  end

  def share_folder(path)
    @client.shares(path)
  end

  def add_file(path, file)
    @client.put_file(path, file)
  end

  def all_files(path)
    @client.metadata(path)
  end

  def delete_file(path)
    @client.file_delete(path)
  end

end