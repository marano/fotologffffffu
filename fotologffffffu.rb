require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require :default
require 'open-uri'
require 'sinatra/cache'
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :cache_enabled, true
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each {|f| require f}

