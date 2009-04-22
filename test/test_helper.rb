ENV["RAILS_ENV"] = "test"
require 'rubygems'
#FIXME: only insert this so I can run tests without clashing with rails 2.3
gem "activesupport", "=2.2.2"
require 'active_support'
require 'active_support/test_case'

require 'shoulda'
require "shoulda/action_controller"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")

class Test::Unit::TestCase
  def create_user_without_validation(opts={})
    user = User.new(opts)
    user.save(false)
    user
  end
end