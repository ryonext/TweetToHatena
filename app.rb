require 'rails_config'
require 'sinatra'
require 'pry'
require 'pry-debugger'

set :root, File.dirname(__FILE__)
register RailsConfig



get '/' do
  binding.pry
  Settings.twitter.consumer_key
end
