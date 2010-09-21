require 'spec_helper'

describe 'Fotolog class' do
  let(:fotolog) { Fotolog.new 'marano' }
  context 'retrieving archive information' do
    before(:each) do
      FakeWeb.register_uri(:get, "http://www.fotolog.com/marano/archive", :body => fixture_file('archive.html'))
    end
    it 'should retrieve user archive URL' do
      fotolog.archive_url.should == 'http://www.fotolog.com/marano/archive'
    end
    it 'should retrieve year url' do
      fotolog.year_archive_url('2004').should == 'http://www.fotolog.com.br/marano/archive?year=2004&month=1'
    end    
    it 'should retrieve all years which have a photo on it' do
      years = fotolog.years
      years.should == ['2004', '2005', '2006', '2007', '2008', '2009', '2010']
    end
  end
  
  context 'retrieving photos' do
    before(:each) do
      FakeWeb.register_uri(:get, "http://www.fotolog.com.br/marano/archive?year=2008&month=09", :body => fixture_file('photos.html'))
    end
    
    it 'should retrieve photo urls' do
      photos = ["http://sp4.fotolog.com.br/photo/20/29/104/marano/1220844280164_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221058240106_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221348619989_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221433699200_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1221691789949_f.jpg", "http://sp4.fotolog.com.br/photo/20/29/104/marano/1222477956299_f.jpg"]

      fotolog.photos_for_month('2008', '09').should == photos
    end
  end
end
