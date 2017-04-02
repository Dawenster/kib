class SeminarsController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @seminars_as_student = @user.assigned_seminars_as_student.order(:scheduled_at)
    @seminars_as_teacher = @user.assigned_seminars_as_teacher.order(:scheduled_at)
  end

  def edit
    @seminar = Seminar.find(params[:seminar_id])
  end

end