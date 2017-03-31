class CoursesController < ApplicationController
  def index
    if params[:s].present?
      search_term = "%#{params[:s].downcase}%"
      query = "LOWER(code) LIKE ? OR LOWER(name) LIKE ?"
      courses = Course.active.where(query, search_term, search_term)
      @course_categories = CourseCategory.where(id: courses.pluck(:course_category_id)).order(:name)
      @course_ids = courses.pluck(:id)
      @searched_term = params[:s]
    else
      @course_categories = CourseCategory.order(:name).joins(:courses).group("course_categories.id")
      @course_ids = Course.pluck(:id)
    end
    if current_user.present?
      @requested_courses_as_student = current_user.requested_courses_as_student
      @requested_courses_as_teacher = current_user.requested_courses_as_teacher
      @above_threshold = current_user.above_request_ratio_threshold?(1, 0)
    end
    flash.now[:alert] = "No courses matching your search for '#{@searched_term}'" if @course_ids.empty? && !@searched_term.blank?
  end
end