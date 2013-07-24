# Load the rails application
require File.expand_path('../application', __FILE__)

USER_ROLE_SYSTEM_ADMIN = 0
USER_ROLE_APP_ADMIN = 1
USER_ROLE_VIEWER = 2

# Initialize the rails application
TOT2::Application.initialize!
