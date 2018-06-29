# frozen_string_literal: true

class DriverManager
  class << self
    def start_driver
      new_driver = Selenium::WebDriver::Driver.for(:remote, opts)
      drivers << new_driver
      new_driver
    end

    def driver
      drivers[0]
    end

    def window(index)
      drivers[index]
    end

    def quit
      quit_driver = drivers.shift
      quit_driver.quit
    end

    private

    def drivers
      @drivers ||= []
    end

    def opts
      {
        url: 'http://localhost:4444/wd/hub',
        desired_capabilities: :chrome
      }
    end
  end
end
