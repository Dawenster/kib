class AdminsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard
    
  end
end