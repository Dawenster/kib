class AssignmentEngine::FinalizeSeminar

  def initialize(seminar)
    @seminar = seminar
  end

  def run!
    @seminar.finalized = true
    
    if @seminar.dropbox_folder_path.blank?
      @seminar.dropbox_folder_path = @seminar.unique_folder_path
      dropbox = DropboxTasks.new
      begin
        dropbox.create_folder(@seminar.dropbox_folder_path)
      rescue => e
        if e.message.include? "file or folder already exists"
          @seminar.dropbox_folder_path = "#{@seminar.dropbox_folder_path}-#{SecureRandom.hex(3)}"
          dropbox.create_folder(@seminar.dropbox_folder_path)
        end
      end
      @seminar.dropbox_url = dropbox.share_folder(@seminar.dropbox_folder_path)["url"]
    end

    seminar_email = Email::Seminars.new(@seminar)
    seminar_email.notify_all_students_of_finalized_assignment
    seminar_email.notify_teacher_of_finalized_assignment

    @seminar.save
  rescue => e
    Rollbar.error(e, seminar_id: @seminar.try(:id))
  end

end