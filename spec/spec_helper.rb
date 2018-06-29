# frozen_string_literal: true

require 'bundler/setup'
require 'selenium-webdriver'
require 'ss/ui/test/controllers/controllers'
require 'ss/ui/test/helpers/failure_helper'
require 'ss/ui/test/webdriver/driver_manager'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FailureHelper

  config.before :suite do
    Selenium::WebDriver.logger.level = :debug
  end

  config.before :all do
    DriverManager.start_driver
    DriverManager.driver.manage.window.resize_to(1366, 768)
  end

  config.after :each do |example|
    handle_failure_if_necessary(example)
  end

  config.after :all do
    DriverManager.quit
  end
end
