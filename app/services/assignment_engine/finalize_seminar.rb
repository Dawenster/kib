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

    seminar_email = Email::Seminars.new(@seminar)
    seminar_email.notify_all_students_of_finalized_assignment
    seminar_email.notify_teacher_of_finalized_assignment

    @seminar.save
  rescue => e
    Rollbar.error(e, seminar_id: @seminar.try(:id))
  end

end