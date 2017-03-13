class RegistrationsController < Devise::RegistrationsController

  def create
    super
    UserMailer.welcome_email(resource).deliver_now unless resource.invalid?
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end