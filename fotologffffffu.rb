require 'rubygems'
require 'bundler'
require 'dalli'
Bundler.setup
Bundler.require :default
require 'open-uri'
set :app_file, __FILE__
set :server, 'webrick'

require './app/application_helper'
require './app/cache'
require './app/fotolog'
require './app/main_controller'

