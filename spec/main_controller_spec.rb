require 'spec_helper'

describe 'main controller' do
  before(:each) { browser.get '/' }
  it 'should be ok' do
    browser.last_response.should be_ok
  end
  it 'should retrieve a list of photos' do
    photos = ["http://sp4.fotolog.com.br/photo/20/29/104/marano/1220844280164_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221058240106_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221348619989_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221433699200_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221691789949_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1222477956299_f.jpg"]
    photos.each {|photo| browser.last_response.body.match(photo).should be_true }
  end
end

