PayPal::Recurring.configure do |config|
  config.sandbox = true
  config.username = ENV['PAYPAL_USER']
  config.password = ENV['PAYPAL_PASS']
  config.signature = ENV['PAYPAL_SIG']
end