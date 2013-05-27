require 'slim'

if development?
  require 'sinatra/reloader'
end

get '/' do
  slim :index
end
