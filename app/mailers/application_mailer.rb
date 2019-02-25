class ApplicationMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: 'from@example.com'
  layout 'mailer'

  def admin_mail(subject, body)
    mail(to: ENV['ADMIN1_MAIL'], subject: subject, body: body)
  end
end
