# frozen_string_literal: true

require 'ss/ui/test/error'

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module WaitCondition
  TIMEOUT = 60
  POLL_INTERVAL = 1

  # Wait for block to succeed without selenium errors
  def wait(timeout = TIMEOUT)
    max_time = Time.now + timeout

    while Time.now < max_time
      begin
        value = yield
        return value
      rescue Selenium::WebDriver::Error::InvalidElementStateError,
             Selenium::WebDriver::Error::StaleElementReferenceError,
             Selenium::WebDriver::Error::UnknownError,
             Selenium::WebDriver::Error::NoSuchElementError => e
        puts "Swallowing error waiting for element: #{e.message}"
      end
      sleep(POLL_INTERVAL)
    end
  end

  # Wait for block to succeed with specified visibility of element
  def wait_for_visibility(is_visible, timeout = TIMEOUT)
    max_time = Time.now + timeout

    while Time.now < max_time
      begin
        yield
        return
      rescue Selenium::WebDriver::Error::InvalidElementStateError,
             Selenium::WebDriver::Error::StaleElementReferenceError => e
        # These exceptions are unrelated to visibility
        puts "Swallowing error waiting for visibility #{is_visible} and saw #{e.message}"
      rescue Selenium::WebDriver::Error::ElementNotVisibleError,
             Selenium::WebDriver::Error::NoSuchElementError => e
        return unless is_visible
        # We're waiting for the element to be visible and we get an element not found keep waiting
        puts "Swallowing error waiting for visibility #{is_visible} and saw #{e.message}"
      end
      sleep(POLL_INTERVAL)
    end

    # Throw exception if our block didn't get evaluated as expected in the specified timeout period
    raise Error::WaitExpiredException, "Wait expired waiting for element visibility #{is_visible}"
  end

  # Wait for block to return true or false
  def wait_until_condition(true_or_false, timeout = TIMEOUT)
    max_time = Time.now + timeout

    while Time.now < max_time
      begin
        result = yield
        return if result == true_or_false
        puts "Waiting for value to be #{true_or_false}. Saw '#{result}.'"
      rescue Selenium::WebDriver::Error::ElementNotVisibleError,
             Selenium::WebDriver::Error::InvalidElementStateError,
             Selenium::WebDriver::Error::NoSuchElementError,
             Selenium::WebDriver::Error::StaleElementReferenceError => e
        # Keep polling the dom for condition success
        puts "Swallowing error #{e.message}"
      end
      sleep(POLL_INTERVAL)
    end

    # Throw an exception
    raise Error::WaitExpiredException, 'Wait expired waiting for element value condition.'
  end

  # Wait for block to return a value equal or not equal to the specified value
  def wait_until_equality(value, is_equal, timeout = TIMEOUT)
    max_time = Time.now + timeout

    while Time.now < max_time
      begin
        result = yield
        # Return back control if the values are equal and they're supposed to be, or
        # the values aren't equal and they aren't supposed to be
        return if result == value && is_equal || result != value && !is_equal
        puts "Waiting for value to #{is_equal ? '' : 'not'} equal #{value}. Observed #{result}."
      rescue Selenium::WebDriver::Error::ElementNotVisibleError,
             Selenium::WebDriver::Error::InvalidElementStateError,
             Selenium::WebDriver::Error::NoSuchElementError,
             Selenium::WebDriver::Error::StaleElementReferenceError => e
        # Keep polling the dom for condition success
        puts "Swallowing error #{e.message}"
      end
      sleep(POLL_INTERVAL)
    end

    # Throw an exception
    raise Error::WaitExpiredException
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
