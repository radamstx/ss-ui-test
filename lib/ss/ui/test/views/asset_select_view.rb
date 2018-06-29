# frozen_string_literal: true

require_relative 'view_requires'

class AssetSelectView
  def asset_by_name(asset_name)
    Button.new(:xpath, "//strong[contains(@class, 'coin-name') and text()='#{asset_name}']")
  end

  def first_visible_asset
    asset_count = DriverManager.driver.find_elements(:css, '.coin-outer').length
    # index starts at 0
    asset_count.times do |index|
      # Xpath index starts at 1
      xpath = "//div[contains(@class, 'coin-outer')][#{index + 1}]"
      asset_button = Button.new(:xpath, xpath)
      return asset_button if asset_button.visible?
    end
  end
end
