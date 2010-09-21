require 'rubygems'
require 'bundler'
 
Bundler.setup

require 'sinatra'

set :app_file, __FILE__
set :root, File.dirname(__FILE__)
#set :config_path, File.join(Sinatra::Application.root, 'config')

#require File.join(Sinatra::Application.config_path, 'config.rb')

Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each {|f| require f}

