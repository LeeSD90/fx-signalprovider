class AdminMailer < ApplicationMailer
  def admin_mail(subject, body)
    @subject = subject
    mail(to: ENV['ADMIN1_MAIL'], subject: subject)
  end
end