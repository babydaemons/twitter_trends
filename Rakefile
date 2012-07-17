#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

TwitterTrends2::Application.load_tasks

task :load => :environment do
  require 'active_record/fixtures'
  ActiveRecord::Base.establish_connection :development
  Fixtures.create_fixtures './test/fixtures/', 'keywords'
end
