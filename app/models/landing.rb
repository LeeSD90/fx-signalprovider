class Landing < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :country
  attribute :message
  attribute :phone
  attribute :call_me
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "New Signup - FX-SignalProvider",
      :to => ENV["MAIL_USERNAME"],
      :from => %("#{name}" <#{email}>)
    }
  end
end