# Load the rails application
require File.expand_path('../application', __FILE__)
require "smtp_tls"

# User Role
USER_ROLE_SYSTEM_ADMIN = 0
USER_ROLE_APP_ADMIN = 1
USER_ROLE_VIEWER = 2

def roleAvailable?(integer)
	return (integer == USER_ROLE_SYSTEM_ADMIN ||
        	integer == USER_ROLE_APP_ADMIN ||
        	integer == USER_ROLE_VIEWER)
end

# Initialize the rails application
TOT2::Application.initialize!

TOT2::Application.configure do
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
end

ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :authentication => :plain,
    :user_name => "please-change-me-at-config-initializers-devise-and-config-environment@gmail.com",
    :password => 'yourpassword'
}
