require 'spec_helper'

describe Fotolog do

  context 'for non existent fotolog' do
    before { FakeWeb.register_uri(:get, "http://www.fotolog.com/this_fotolog_doesnt_exists/archive", :body => fixture_file('non_existent_fotolog.html'), :status => ["404", "Not Found"]) }
    let(:fotolog) { Fotolog.new 'this_fotolog_doesnt_exists' }
    it 'should tell it is not valid' do
      fotolog.should_not be_valid
    end
  end

  context 'that exists' do
    before(:each) do
      FakeWeb.register_uri(:get, "http://www.fotolog.com/marano/archive", :body => fixture_file('archive.html'))
    end
    let(:fotolog) { Fotolog.new 'marano' }
    it 'should tell it is valid' do
      fotolog.should be_valid
    end
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
      it 'should parse photo url correctly' do
        photo = 'http://spc.fotolog.com.br/photo/12/16/103/pink_that/1189983175_t.jpg'
        big_photo = 'http://spc.fotolog.com.br/photo/12/16/103/pink_that/1189983175_f.jpg'
        fotolog.full_image_for(photo).should == big_photo
      end
      it 'should parse photo url correctly even with crazy urls' do
        photo = 'http://spc.fotolog.com.br/photo/12/16/103/p_tink_th_tat/1189983175_t.jpg'
        big_photo = 'http://spc.fotolog.com.br/photo/12/16/103/p_tink_th_tat/1189983175_f.jpg'
        fotolog.full_image_for(photo).should == big_photo
      end
    end

    context 'updating photos from a cached fotolog' do
      let (:fotolog) {Fotolog.new 'gabocaa'}
      before(:each) do

      end
      pending 'should get new photos to cache' do
        FakeWeb.register_uri(:get, "http://www.fotolog.com.br/gabocaa/archive", :body => fixture_file('uncached_archive.html') )
        mock_requests_fixture_for_fotolog 'gabocaa'
        fotolog.retrieve_photos
        fotolog = Fotolog.new 'gabocaa'
        fotolog.update_cache.should be_true
        fotolog.update_cache.should be_false
      end
      pending 'should not find any photos to a fotolog not updated' do
        FakeWeb.register_uri(:get, "http://www.fotolog.com.br/gabocaa/archive", :body => fixture_file('cached_archive.html') )
        mock_requests_fixture_for_fotolog 'gabocaa'
        fotolog.retrieve_photos
        fotolog = Fotolog.new 'gabocaa'
        fotolog.update_cache.should be_false

      end
    end
  end
end

