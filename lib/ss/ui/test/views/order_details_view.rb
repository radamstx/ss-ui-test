# frozen_string_literal: true

require_relative 'view_requires'

class OrderDetailsView
  # @return [TextInput]
  attr_reader :deposit_amount, :receive_amount, :destination_address, :refund_address

  # @return [BaseElement]
  attr_reader :deposit_min, :deposit_max, :miner_fee

  def initialize
    @deposit_amount      = TextInput.new(:name, 'depositAmount')
    @receive_amount      = TextInput.new(:name, 'amount')
    @destination_address = TextInput.new(:name, 'withdrawal')
    @refund_address      = TextInput.new(:name, 'refund')
    @deposit_min         = BaseElement.new(:xpath, '//label[text()="Deposit Min"]/..')
    @deposit_max         = BaseElement.new(:xpath, '//span[@ng-show="formData.type == 2"]')
    @miner_fee           = BaseElement.new(:xpath, '//span[@ng-show="quoteData"]')
  end
end
