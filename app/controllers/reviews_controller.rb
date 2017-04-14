class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def create
    clean_up_reason_for_taking_seminar
    @review = Review.new(review_params)
    if @review.save
      redirect_to classes_path, notice: "Successfully reviewed #{@review.seminar.course.code_and_name}"
    else
      @seminar = @review.seminar
      flash.now[:alert] = error_display_as_sentence(@review.errors)
      render "seminars/review"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @seminar = @review.seminar
  end

  def update
    @review = Review.find(params[:id])
    clean_up_reason_for_taking_seminar
    @review.assign_attributes(review_params)
    if @review.save
      redirect_to classes_path, notice: "Successfully updated review for #{@review.seminar.course.code_and_name}"
    else
      @seminar = @review.seminar
      flash.now[:alert] = error_display_as_sentence(@review.errors)
      render "seminars/review"
    end
  end

  def destroy
    review = Review.find(params[:id])
    success_message = "Successfully deleted review for #{review.seminar.course.code_and_name}"
    if review.destroy
      redirect_to classes_path, notice: success_message
    else
      redirect_to classes_path, alert: error_display_as_sentence(review.errors)
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :user_id,
      :seminar_id,
      :rating,
      :feedback_for_teacher,
      :feedback_for_kib,
      :teacher_id,
      :reason_for_taking_seminar
    )
  end

  def clean_up_reason_for_taking_seminar
    if params[:review][:reason_for_taking_seminar] == "Other"
      params[:review][:reason_for_taking_seminar] = "Other: #{params[:other_reason_for_taking_seminar]}"
    end
  end

end