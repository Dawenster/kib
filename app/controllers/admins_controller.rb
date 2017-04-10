class AdminsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard
    @unfinalized_seminars = Seminar.not_finalized
    @finalized_seminars = Seminar.finalized.incomplete
    @completed_seminars = Seminar.completed
  end

  def run_assignment_engine
    AssignmentEngine::Controller.assign_all_outstanding_requests
    redirect_to dashboard_path, notice: "Assignment Engine successfully run"
  end

  def finalize_all
    unfinalized_seminars = Seminar.not_finalized
    unfinalized_seminars.each do |seminar|
      AssignmentEngine::FinalizeSeminar.new(seminar).run!
    end
    redirect_to dashboard_path, notice: "Successfully finalized all classes"
  end

  def finalize
    seminar = Seminar.find(params[:seminar_id])
    if AssignmentEngine::FinalizeSeminar.new(seminar).run!
      redirect_to dashboard_path, notice: "Successfully finalized class ID: #{seminar.id}"
    else
      redirect_to dashboard_path, alert: error_display_as_sentence(seminar.errors)
    end
  end
end