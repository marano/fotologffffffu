require 'spec_helper'
include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'main controller' do
  context 'home page' do
    before { browser.get '/' }
    it 'should be ok' do
      browser.last_response.should be_ok
    end
  end
  
  context 'submited a user via a form' do
    mock_requests_fixture_for_fotolog
    get '/', :username => 'marano'
    last_response.headers['Location'].should == '/marano'    
  end
  
  context 'given a fotolog' do
    before do
      mock_requests_fixture_for_fotolog
      browser.get '/marano'
    end
    it 'should be ok' do
      browser.last_response.should be_ok
    end
    it 'should retrieve a list of photos' do
      photos = ["http://sp4.fotolog.com.br/photo/20/29/104/marano/1220844280164_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221058240106_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221348619989_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221433699200_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221691789949_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1222477956299_f.jpg"]
      
      photos.each {|photo| browser.last_response.body.match(photo).should be_true }
    end
  end
end

