class RequestsController < ApplicationController

  before_action :authenticate_user!

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
      errors = request.errors.full_messages.to_sentence.downcase.capitalize
      respond_to do |format|
        format.json do
          render json: { errors: errors }
        end

        format.html do
          redirect_to courses_path, alert: errors
        end
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