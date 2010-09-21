require 'fotolog_parser'

require 'sinatra'
require 'rack/test'
require 'fakeweb'
set :environment, :test

set :views => File.join(File.dirname(__FILE__), "..", "views")

@@browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))


FakeWeb.allow_net_connect = true

def browser
  @@browser
end

def fixture_file(file)
  File.open(File.join(File.dirname(__FILE__), 'fixtures', file), 'r:utf-8').read
end

