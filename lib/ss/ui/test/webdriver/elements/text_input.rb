# frozen_string_literal: true

require_relative 'base_element'

class TextInput < BaseElement
  def type(text)
    wait { element.clear }
    _type(text)
  end

  def append_type(text)
    _type(text)
  end

  def press_return
    wait { element.send_keys(:return) }
  end

  alias force_submit press_return

  def value
    attribute('value')
  end

  private

  def _type(text)
    wait { element.send_keys(text) }
  end
end
