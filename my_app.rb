require './lib/swaggering'

# only need to extend if you want special configuration!
class MyApp < Swaggering
  register Sinatra::ConfigFile
  configure do |config|
    config.api_version = '1.0.0'
  end
end

# include the api files
Dir['./api/*.rb'].each do |file|
  require file
end
