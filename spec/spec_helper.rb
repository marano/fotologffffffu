require 'fotologffffffu'

require 'sinatra'
require 'rack/test'
require 'fakeweb'
require 'mocha'

set :environment, :test

require 'support'

set :views => File.join(File.dirname(__FILE__), "..", "views")

FakeWeb.allow_net_connect = false

def fixture_file(file)
  File.open(File.join(File.dirname(__FILE__), 'fixtures', file), 'r:utf-8').read
end

def mock_requests_fixture_for_fotolog name
  FakeWeb.register_uri(:get, "http://www.fotolog.com/#{name}/archive", :body => fixture_file('archive.html'))

  (2003..2010).to_a.each do |year|
    (1..12).to_a.each do |month|
      FakeWeb.register_uri(:get, "http://www.fotolog.com.br/#{name}/archive?year=#{year}&month=#{'0' if month.to_i < 10}#{month}", :body => fixture_file('photos.html'))
    end
  end

  FakeWeb.register_uri(:get, "http://www.fotolog.com.br/#{name}/archive?year=2008&month=09", :body => fixture_file('photos.html'))
end

Cache.stubs(:instance).returns(CacheStub.new)

