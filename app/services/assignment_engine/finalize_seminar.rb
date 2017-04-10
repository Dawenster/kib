class AssignmentEngine::FinalizeSeminar

  def initialize(seminar)
    @seminar = seminar
  end

  def run!
    @seminar.finalized = true
    @seminar.dropbox_folder_path = @seminar.unique_folder_path

    dropbox = DropboxTasks.new
    dropbox.create_folder(@seminar.dropbox_folder_path)
    @seminar.dropbox_url = dropbox.share_folder(@seminar.dropbox_folder_path)["url"]

    @seminar.save
  end

end