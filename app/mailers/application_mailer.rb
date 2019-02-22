class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def admin_mail(subject, body)
    mail(to: ENV['ADMIN1_MAIL']ENV['ADMIN1_MAIL'], subject: subject, body: body)
  end
end
