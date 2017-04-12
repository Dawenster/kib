class RequestsController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @requests = @user.all_requests.order("created_at DESC")
  end

  def create
    request = Request.new(request_params)
    if request.save
      respond_to do |format|
        success_message = "Successfully requested as #{request.role} for: #{request.course.code_and_name}"
        format.json do
          flash[:notice] = success_message
          render json: {
            partial: (render_to_string partial: "courses/requested.html.slim", layout: false )
          }
        end

        format.html do
          redirect_to courses_path, notice: success_message
        end
      end
    else
      errors = error_display_as_sentence(request.errors)
      respond_to do |format|
        format.json do
          flash[:alert] = errors
          render json: { errors: errors }
        end

        format.html do
          redirect_to courses_path, alert: errors
        end
      end
    end
  end

  def destroy
    request = Request.find(params[:id])
    respond_to do |format|
      if request.destroy
        success_message = "Successfully cancelled #{request.role} request for: #{request.course.code_and_name}"
        flash[:notice] = success_message
        render json: { message: success_message } and return
      else
        flash[:alert] = request.errors
        render json: { errors: request.errors } and return
      end
    end
  end

  private

  def request_params
    params.permit(
      :student_id,
      :teacher_id,
      :course_id
    )
  end

end