require 'fotolog_parser'

require 'sinatra'
require 'rack/test'

set :environment, :test

set :views => File.join(File.dirname(__FILE__), "..", "views")

@@browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))

def browser
  @@browser
end

