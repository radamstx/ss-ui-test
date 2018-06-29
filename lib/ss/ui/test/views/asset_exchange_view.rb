# frozen_string_literal: true

require_relative 'view_requires'

class AssetExchangeView
  # @return [Button]
  attr_reader :deposit_currency_button, :receive_currency_button, :quick_button, :precise_button, :continue_button

  # @return [BaseElement]
  attr_reader :current_deposit, :current_receive

  def initialize
    @deposit_currency_button = Button.new(:css, '.coin-selection .input-coin')
    @receive_currency_button = Button.new(:css, '.coin-selection .output-coin')

    @current_deposit = BaseElement.new(:css, '.coin-selection .input-coin .selected-coin .notranslate')
    @current_receive = BaseElement.new(:css, '.coin-selection .output-coin .selected-coin .notranslate')

    @quick_button = Button.new(:css, 'button[ng-click="type(1)"]')
    @precise_button = Button.new(:css, 'button[ng-click="type(2)"]')
    @continue_button = Button.new(:css, 'a.submit')
  end
end
