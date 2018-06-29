# frozen_string_literal: true

require_relative 'base_element'

class Button < BaseElement
  # Click the button
  def click
    wait { element.click }
  end
end
