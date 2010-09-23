require 'rubygems'
require 'bundler'
require 'dalli'
Bundler.setup
Bundler.require :default
require 'open-uri'
set :app_file, __FILE__
@@cache = Dalli::Client.new('localhost:11211')
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each {|f| require f}

