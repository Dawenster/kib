class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = Rails.application.routes.url_helpers.courses_url(host: ENV["HOST"])
    email = email_to_use(@user)
    mail(to: email, subject: 'Welcome to Kellogg in a Bottle')
  end
  
end