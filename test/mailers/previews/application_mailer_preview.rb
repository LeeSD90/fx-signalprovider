class AdminMailerPreview < ActionMailer::Preview
  def admin_mail
    AdminMailer.admin_mail("test", "tesstttt")
  end
end