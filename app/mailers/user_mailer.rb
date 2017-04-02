class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = Rails.application.routes.url_helpers.courses_url(host: ENV["HOST"])
    mail(to: @user.email, subject: 'Welcome to Kellogg in a Bottle')
  end
end