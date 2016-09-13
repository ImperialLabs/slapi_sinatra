require 'sinatra'
require 'sinatra/base'
require 'sinatra/config_file'

class MyApp < Sinatra::Base
  register Sinatra::ConfigFile
  #enable :sessions
  config_file 'config/environments.yml'

  set :environment, :production

  configure :production, :development, :test do
    enable :logging
  end

end

require_relative 'api/init'
