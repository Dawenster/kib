class SeminarsController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @seminars_as_student = @user.assigned_seminars_as_student.finalized.order(:scheduled_at)
    @seminars_as_teacher = @user.assigned_seminars_as_teacher.finalized.order(:scheduled_at)
  end

  def edit
    @seminar = Seminar.find(params[:seminar_id])
    redirect_to back_or_default, alert: "You cannot edit this class anymore" and return if @seminar.completed
    redirect_to back_or_default, alert: "You cannot edit this class" and return if @seminar.teacher != current_user
  end

  def update
    @seminar = Seminar.find(params[:id])
    clean_up_scheduled_at
    @seminar.assign_attributes(seminar_params)

    if @seminar.save
      success_message = "Class successfully updated"
      redirect_to classes_path, notice: success_message
    else
      errors = error_display_as_sentence(@seminar.errors)
      redirect_to classes_path, alert: errors
    end
  end

  def complete
    @seminar = Seminar.find(params[:id])
    @seminar.assign_attributes(seminar_params)

    if @seminar.save
      Email::Seminars.new(@seminar).notify_students_to_leave_review
      Requests::Controller.auto_request_as_teacher(@seminar)
      success_message = "Class successfully completed"
      flash[:notice] = success_message
      render json: { message: success_message, return_path: classes_path }
    else
      errors = error_display_as_sentence(@seminar.errors)
      flash[:alert] = errors
      render json: { errors: errors }
    end
  end

  def upload_file_to_dropbox
    if params[:seminar].present?
      seminar = Seminar.find(params[:id])
      file_to_upload = params[:seminar][:file]
      dropbox = DropboxTasks.new
      modified_filename = safe_file_name(file_to_upload.original_filename)
      upload_path_name = upload_path(seminar, modified_filename)
      dropbox.add_file(upload_path_name, file_to_upload.tempfile)

      redirect_to classes_path, notice: "File #{modified_filename} successfully added to Dropbox"
    else
      redirect_to classes_path, alert: "Please select a file first"
    end
  end

  def delete_dropbox_file
    seminar = Seminar.find(params[:id])
    filename = params[:filename]
    dropbox = DropboxTasks.new
    dropbox.delete_file("#{seminar.dropbox_folder_path}/#{filename}")
    redirect_to classes_path, notice: "File #{filename} successfully deleted from Dropbox"
  end

  def review
    @seminar = Seminar.find(params[:seminar_id])
    redirect_to back_or_default, alert: "You cannot review your own class" and return if @seminar.teacher == current_user
    redirect_to back_or_default, alert: "You did not take this class" and return if !@seminar.students.include?(current_user)
    redirect_to back_or_default, alert: "Class is not completed yet" and return if @seminar.incomplete?
    @review = Review.new
  end

  private

  def seminar_params
    params.require(:seminar).permit(
      :location,
      :description,
      :scheduled_at,
      :completed
    )
  end

  def clean_up_scheduled_at
    if params[:seminar][:scheduled_at].present?
      zone_name = Time.current.dst? ? "CDT" : "CST"
      params[:seminar][:scheduled_at] = DateTime.strptime("#{params[:seminar][:scheduled_at]} #{zone_name}", "%m/%d/%Y %H:%M %p %Z")
    end
  end

  def upload_path(seminar, modified_filename)
    "#{seminar.dropbox_folder_path}/#{modified_filename}"
  end

  def safe_file_name(filename)
    filename_parts = filename.split(".")
    extension = filename_parts.pop
    filename_parts.join("").parameterize + ".#{extension}"
  end

end