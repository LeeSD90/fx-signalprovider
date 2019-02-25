class ApplicationMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: ENV['MAIL_USERNAME']
  layout 'mailer'

end
