class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def test_mail(email)
    mail(to: email, subject: 'Test mail', body: 'Body Stuff')
  end
end
