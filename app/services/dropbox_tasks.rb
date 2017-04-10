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

end