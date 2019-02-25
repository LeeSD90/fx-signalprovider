class AdminMailer < ApplicationMailer
  def admin_mail(subject, body)
    mail(to: ENV['ADMIN1_MAIL'], subject: subject)
  end
end