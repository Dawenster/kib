class AdminsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard
  end

  def run_assignment_engine
    AssignmentEngine::Controller.assign_all_outstanding_requests
    redirect_to dashboard_path, notice: "Assignment Engine successfully run"
  end
end