# Load the rails application
require File.expand_path('../application', __FILE__)


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
