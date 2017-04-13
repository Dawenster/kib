class ApplicationMailer < ActionMailer::Base
  
  default from: '"Kellogg in a Bottle" <kellogginabottle@gmail.com>'

  def email_to_use(user)
    if user.can_send_email?
      user.email
    elsif test_email.present?
      test_email
    else
      test_sendgrid_email
    end
  end

  def test_email
    ENV["TEST_EMAIL"]
  end

  def test_sendgrid_email
    "test@sink.sendgrid.net"
  end

end