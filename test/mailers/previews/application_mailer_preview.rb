class ApplicationMailerPreview < ActionMailer::Preview
  def admin_mail
    ApplicationMailer.admin_mail("test", "tesstttt")
  end
end