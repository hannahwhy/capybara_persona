require 'sinatra'

$page = File.read(File.expand_path('../index.html', __FILE__))

class App < Sinatra::Base
  get '/' do
    $page
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
