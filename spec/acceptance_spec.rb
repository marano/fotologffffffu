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
      fill_in 'name', :with => 'marano'
      click_button 'search_button'
    end
    it 'should open user photos' do
      page.should have_xpath "//div[@id='photos']"
    end
    it 'should show the user name on the search box' do
      find_field('name').value.should == 'marano'
    end
  end
  context 'retrieving last users' do
    before do
      mock_requests_fixture_for_fotolog
      fill_in 'name', :with => 'marano'
      click_button 'search_button'
    end
    it 'should show last user at home' do
      visit '/'
      page.has_css?('#recent_user_marano').should be true
    end
  end
end

