require_relative '../fotologffffffu'

require 'sinatra'
require 'rack/test'
require 'webmock'
require 'webmock/rspec'
require 'mocha/setup'

set :environment, :test

require_relative 'support'

set :views => File.join(File.dirname(__FILE__), "..", "views")

WebMock.disable_net_connect!(:allow_localhost => true)

def fixture_file(file)
  File.open(File.join(File.dirname(__FILE__), 'fixtures', file), 'r:utf-8').read
end

def mock_requests_fixture_for_fotolog name
  stub_request(:get, "http://www.fotolog.com/#{name}/archive/").to_return(:body => fixture_file('archive.html'))
  stub_request(:get, "http://www.fotolog.com.br/#{name}/archive/").to_return(:body => fixture_file('archive.html'))

  (2003..2013).to_a.each do |year|
    (1..12).to_a.each do |month|
      stub_request(:get, "http://www.fotolog.com.br/#{name}/archive/#{month}/#{year}/").to_return(:body => fixture_file('photos.html'))
    end
  end

  stub_request(:get, "http://www.fotolog.com.br/#{name}/archive/9/2008/").to_return(:body => fixture_file('photos.html'))
end

Cache.stubs(:instance).returns(CacheStub.new)

