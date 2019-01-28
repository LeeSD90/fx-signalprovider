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

  def country_name
    c = ISO3166::Country[self.country]
    if c.nil? then return "Not given"
    else return c.translations[I18n.locale.to_s] || c.name end
  end
end