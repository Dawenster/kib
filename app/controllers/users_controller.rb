class UsersController < ApplicationController

  before_action :authenticate_user!

  def update
    user = User.find(params[:id])
    user.assign_attributes(user_params)
    respond_to do |format|
      if user.save
        format.json do
          render json: { message: "User updated successfully" }
        end
      else
        format.json do
          render json: { errors: error_display_as_sentence(user.errors) }
        end
      end
    end
  end

  private

  def user_params
    params.permit(
      :assignable
    )
  end

end