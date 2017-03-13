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
    flash[:alert] = "No courses matching your search for '#{@searched_term}'" if @course_ids.empty?
  end
end