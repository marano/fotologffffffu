require 'rubygems'
require 'bundler'
require 'dalli'
Bundler.setup
Bundler.require :default
require 'open-uri'
set :app_file, __FILE__

require 'app/cache'
require 'app/fotolog'
require 'app/main_controller'

