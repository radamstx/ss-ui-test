# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Asset Exchange' do
  before(:each) do
    @controller = AssetExchangeController.new
    @controller.go_to
  end

  it 'default asset exchange doesnt have the same asset' do
    expect(@controller.current_deposit_currency).to_not eq(@controller.current_receive_currency)
  end

  it 'default deposit asset is Bitcoin' do
    expect(@controller.current_deposit_currency).to eq('Bitcoin')
  end

  it 'default receive asset is Ether' do
    expect(@controller.current_receive_currency).to eq('Ether')
  end

  it 'allows for selection of the deposit asset' do
    @controller.select_deposit_currency('Bitcoin Cash')
    expect(@controller.current_deposit_currency).to eq('Bitcoin Cash')
  end

  it 'allows for selection of the receive asset' do
    @controller.select_receive_currency('Dogecoin')
    expect(@controller.current_receive_currency).to eq('Dogecoin')
  end

  it 'prefills asset exchange form based on assets selected' do
    @controller.select_deposit_currency('Dogecoin')
    @controller.select_receive_currency('Bitcoin')
    @controller.begin_quick_transaction
    expect(@controller.prefilled_addresses_valid?('Dogecoin', 'Bitcoin')).to be_truthy
  end
end
