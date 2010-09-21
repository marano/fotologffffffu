require 'spec_helper'

describe 'Fotolog class' do
  let(:fotolog) {Fotolog.new}
  context 'retrieving archive information' do
    before(:each) do
      FakeWeb.register_uri(:get, "http://www.fotolog.com/marano/archive", :body => fixture_file('archive.html'))

    end
    it 'should retrieve user archive URL' do
      fotolog.get_archive_url('marano').should == 'http://www.fotolog.com/marano/archive'
    end
    
    it 'should retrieve all years which have a photo on it' do
      years = fotolog.get_years 'http://www.fotolog.com/marano/archive'
      years.should == ['2004', '2005', '2006', '2007', '2008', '2009', '2010']
    end
  end
end
