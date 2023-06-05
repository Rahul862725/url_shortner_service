require 'sinatra'
require 'securerandom'

# In-memory data store to store URL mappings
URL_MAP = {}
set :public_folder, File.dirname(__FILE__) + '/views'


get '/' do
  erb :index
end

post '/shorten' do
  long_url = params[:long_url]
  short_url = generate_short_url
  URL_MAP[short_url] = long_url
  erb :shortened, locals: { short_url: short_url }
end

get '/:short_url' do
  long_url = URL_MAP[params[:short_url]]
  if long_url
    redirect long_url
  else
    status 404
    erb :not_found
  end
end

def generate_short_url
  # Generate a unique short URL using SecureRandom
  SecureRandom.hex(3)
end
