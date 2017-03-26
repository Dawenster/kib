class RequestsController < ApplicationController

  before_action :authenticate_user!

  def create
    request = Request.new(request_params)
    if request.save
      redirect_to courses_path, notice: "Successfully requested as #{request.role} for: #{request.course.code} - #{request.course.name}"
    else
      redirect_to courses_path, alert: request.errors.full_messages.to_sentence.downcase.capitalize
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