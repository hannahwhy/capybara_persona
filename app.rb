require 'sinatra'

$page = File.read(File.expand_path('../index.html', __FILE__))

class App < Sinatra::Base
  get '/' do
    $page
  end
end
