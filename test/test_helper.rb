ENV["RAILS_ENV"] = "test"
#require 'rubygems'
#FIXME: I only inserted this so I can run tests without clashing with rails 2.3
# once this issue is fixed, this should be removed
#gem "activesupport", "=2.2.2"
#require 'active_support'
#require 'active_support/test_case'

#IMPORTANT! This line should not be moved under "require 'factory_girl'"
# factory_girl tries to load the test/factories file (of the host app, not the plugin!)
# before the models are defined and will crash miserably.
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")

require 'test_help'
require 'test/unit'

require 'shoulda'
require "shoulda/action_controller"

require 'factory_girl'
require File.expand_path(File.dirname(__FILE__) + '/factories')

class ActiveSupport::TestCase
  def create_user_without_validation(opts={})
    user = User.new(opts)
    user.save(false)
    user
  end
end
