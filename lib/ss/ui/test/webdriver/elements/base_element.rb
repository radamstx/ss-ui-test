# frozen_string_literal: true

require_relative 'element_requires'

class BaseElement
  include WaitCondition

  # @param by [Symbol] (:id, :css, :xpath, etc.)
  # @param locator [String] locator value
  def initialize(by, locator)
    @by = by
    @locator = locator
  end

  def text
    wait { element.text }
  end

  def attribute(name)
    wait { element.attribute(name) }
  end

  def id
    wait { element.attribute('id') }
  end

  def value
    wait { element.attribute('value') }
  end

  # rubocop:disable Metrics/MethodLength
  def visible?
    max_time = Time.now + TIMEOUT

    while Time.now < max_time
      begin
        return DriverManager.driver.find_element(@by, @locator).displayed?
      rescue Selenium::WebDriver::Error::InvalidElementStateError,
             Selenium::WebDriver::Error::StaleElementReferenceError,
             Selenium::WebDriver::Error::UnknownError
        sleep(POLL_INTERVAL)
      rescue Selenium::WebDriver::Error::NoSuchElementError
        return false
      end
    end

    raise Error::WaitExpiredException
  end
  # rubocop:enable Metrics/MethodLength

  # Wait until the element is visible
  def wait_until_visible
    wait_for_visibility(true) { DriverManager.driver.find_element(@by, @locator).displayed? }
  end

  # Wait until the element is not visible
  def wait_until_not_visible
    wait_for_visibility(false) { DriverManager.driver.find_element(@by, @locator).displayed? }
  end

  # Wait for attribute name to equal attribute value
  def wait_for_attribute_to_equal(attribute_name, attribute_value)
    wait_until_equality(attribute_value, true) { element.attribute(attribute_name) == attribute_value }
  end

  # Wait for attribute name to not equal attribute value
  def wait_for_attribute_to_not_equal(attribute_name, attribute_value)
    wait_until_equality(attribute_value, false) { element.attribute(attribute_name) != attribute_value }
  end

  # Wait for element to have class
  def wait_for_class(wait_for_class)
    wait_until_condition(true) { element.attribute('class').include? wait_for_class }
  end

  # Wait for element to not have class
  def wait_for_absence_of_class(wait_for_absence_of_class)
    wait_until_condition(false) { element.attribute('class').include? wait_for_absence_of_class }
  end

  # Does the element have the specified class?
  # @return [TrueClass, FalseClass]
  def class?(has_class)
    attribute('class').include? has_class
  end

  protected

  # Wraps element lookup and returns a Selenium::WebDriver::Element to interact with inside of other
  # wait conditions so we're catching things like StaleElementReferenceException
  # @return [Selenium::WebDriver::Element]
  def element
    wait { DriverManager.driver.find_element(@by, @locator) }
  end
end
