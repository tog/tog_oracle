require_plugin 'acts_as_taggable_on_steroids'
require_plugin 'acts_as_abusable'

require "i18n" unless defined?(I18n)
Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
scheduler.every "1d" do
  Oracle::Question.send_close_requests_for_overdues
end



