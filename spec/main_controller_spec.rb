require 'spec_helper'

describe 'main controller' do
  before(:each) do
    FakeWeb.register_uri(:get, "http://www.fotolog.com/marano/archive", :body => fixture_file('archive.html'))
    #FakeWeb.register_uri(:get, %r|http://www.fotolog\.com.br/marano/|, [[:body => fixture_file('empty_archive.html')], [:body => fixture_file('empty_archive.html')], [:body => fixture_file('empty_archive.html')], [:body => fixture_file('photos.html')]] )
    (2003..2010).to_a.each do |year|
      (1..12).to_a.each do |month|
        FakeWeb.register_uri(:get, "http://www.fotolog.com.br/marano/archive?year=#{year}&month=#{'0' if month.to_i < 10}#{month}", :body => fixture_file('photos.html'))
      end
    end
    
    FakeWeb.register_uri(:get, "http://www.fotolog.com.br/marano/archive?year=2008&month=09", :body => fixture_file('photos.html'))
    
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

