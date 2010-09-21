require 'spec_helper'

require 'capybara'
require 'capybara/dsl'

include Capybara

Capybara.app = Sinatra::Application.new

describe 'home page' do
  before { visit '/' }
  context 'filling username and clicking go' do
    before do
      mock_requests_fixture_for_fotolog
      fill_in 'username', :with => 'marano'
      click_button 'go'
    end
    it 'should open user photos' do
      page.should have_xpath "//div[@id='photos']"
    end
  end
end

