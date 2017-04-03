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

  def update
    @seminar = Seminar.find(params[:id])
    @seminar.assign_attributes(seminar_params)
    if @seminar.save
      redirect_to classes_path, notice: "Class successfully updated"
    else
      render "edit", alert: error_display_as_sentence(@seminar.errors)
    end
  end

  private

  def seminar_params
    params.require(:seminar).permit(
      :location,
      :description,
      :scheduled_at
    )
  end

end