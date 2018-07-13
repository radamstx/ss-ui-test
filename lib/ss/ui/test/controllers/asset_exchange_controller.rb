# frozen_string_literal: true

require 'ss/ui/test/views/asset_exchange_view'
require 'ss/ui/test/views/asset_select_view'
require 'ss/ui/test/views/order_details_view'

class AssetExchangeController
  include WaitCondition

  def initialize
    @view               = AssetExchangeView.new
    @asset_select_view  = AssetSelectView.new
    @order_details_view = OrderDetailsView.new
  end

  def go_to
    DriverManager.driver.get('https://shapeshift.io/#/coins')
    wait_until_equality(nil, false) { current_deposit_currency }
    wait_until_equality(nil, false) { current_receive_currency }
  end

  def current_deposit_currency
    @view.current_deposit.text
  end

  def current_receive_currency
    @view.current_receive.text
  end

  def select_deposit_currency(deposit_currency)
    @view.deposit_currency_button.click
    @asset_select_view.asset_by_name(deposit_currency).click
    wait_until_equality(deposit_currency, true) { current_deposit_currency }
  end

  def select_receive_currency(receive_currency)
    @view.receive_currency_button.click
    @asset_select_view.asset_by_name(receive_currency).click
    wait_until_equality(receive_currency, true) { current_receive_currency }
  end

  def deposit_currency_visible?(deposit_currency)
    @view.deposit_currency_button.click
    @asset_select_view.asset_by_name(deposit_currency).visible?
  end

  def receive_currency_visible?(receive_currency)
    @view.receive_currency_button.click
    @asset_select_view.asset_by_name(receive_currency).visible?
  end

  def begin_quick_transaction
    @view.quick_button.click
    @view.continue_button.click
  end

  def begin_precise_transaction
    @view.precise_button.click
    @view.continue_button.click
  end

  def prefilled_addresses_valid?(deposit_currency, receive_currency)
    dest_placeholder   = @order_details_view.destination_address.attribute('placeholder')
    refund_placeholder = @order_details_view.refund_address.attribute('placeholder')

    dest_placeholder == "Your #{receive_currency} Address (destination address)" &&
      refund_placeholder == "Your #{deposit_currency} Refund Address"
  end
end
