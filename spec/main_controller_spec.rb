require 'spec_helper'

describe 'main controller' do
  it 'should be ok' do
    browser.get '/'
    puts browser.last_response.inspect
    browser.last_response.should be_ok
  end
end

