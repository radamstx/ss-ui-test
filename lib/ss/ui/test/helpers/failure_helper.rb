# frozen_string_literal: true

require_relative '../../../test'

module FailureHelper
  def handle_failure_if_necessary(example)
    return unless example.exception
    test_name = example_to_test_name(example)
    screenshot(test_name)
    page_source(test_name)
    browser_logs(test_name)
  end

  # Store screenshot
  def screenshot(file_title)
    filename = Ss::Ui::Test.project_root + "/failure_data/#{file_title}.png"
    DriverManager.driver.save_screenshot(filename)
  end

  # Store raw page source
  def page_source(file_title)
    filename = Ss::Ui::Test.project_root + "/failure_data/#{file_title}.html"
    File.open(filename, 'w') { |file| file.write(DriverManager.driver.page_source) }
  end

  # Store browser logs
  # rubocop:disable Metrics/AbcSize
  def browser_logs(file_title)
    DriverManager.driver.manage.logs.available_types.each do |log_type|
      log = DriverManager.driver.manage.logs.get(log_type)
      file_name = Ss::Ui::Test.project_root + "/failure_data/#{file_title}_#{log_type}.log"
      write_log_file(log, file_name)
    end
  rescue NoMethodError
    puts "Swallowing NoMethodError trying to get logs for browser #{DriverManager.driver.browser}"
  end
  # rubocop:enable Metrics/AbcSize

  private

  # Makes file friendly name
  def example_to_test_name(example)
    # Take describe block amd example name, and remove all special characters and white space
    test_name = example.full_description.dup
    test_name = test_name.downcase.tr!(' ', '_')
    test_name.gsub(/\W/, '')
  end

  # Writes out lines from the log file
  def write_log_file(log, file_name)
    return unless log.count.positive?

    File.delete(file_name) if File.file?(file_name)

    File.open(file_name, 'a') do |file|
      log.each do |log_line|
        file.puts("#{log_line.level} #{log_line.timestamp} #{log_line.message}")
      end
    end
  end
end
