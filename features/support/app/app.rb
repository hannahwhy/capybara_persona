require 'sinatra'

class App < Sinatra::Base
  get '/' do
    File.read(File.expand_path('../index.html', __FILE__))
  end

  get '/jquery.min.js' do
    File.read(File.expand_path('../jquery.min.js', __FILE__))
  end

  post '/verify' do
    status 200
  end

  post '/signOut' do
    status 200
  end
end
