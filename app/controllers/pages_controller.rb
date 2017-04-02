class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:profile]

  def profile
    @user = current_user
    @requests = @user.all_requests.order("created_at DESC")
  end

end