require 'rack'
require 'logger'
require_relative './rack_apps/socket_client_run'

App = Rack::Builder.new do
  use Rack::CommonLogger, Logger.new('log/app.log')
  use Rack::Deflater
  use Rack::Reloader

  map '/send_initial_data' do
    run SocketClientRun
  end
end

run App
