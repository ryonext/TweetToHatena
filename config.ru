require 'rubygems'
require './require.rb'

set :root, File.dirname(__FILE__)
register RailsConfig

run Sinatra::Application
