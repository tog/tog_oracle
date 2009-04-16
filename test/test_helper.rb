ENV["RAILS_ENV"] = "test"
require 'rubygems'
require 'active_support'
require 'active_support/test_case'

require 'shoulda'
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
