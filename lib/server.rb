require 'eventmachine'
require 'yaml'
require_relative './data_processing.rb'
require_relative './support/create_pid'

Dir[File.dirname(__FILE__) + '/servers/*.rb'].each { |file| load file }

CONF = YAML.load_file('./config/config.yml')

Process.daemon(true, true) if ENV['APP_ENV'].eql?('production')

CreatePid.for(file: __FILE__, pid: Process.pid)

EventMachine.run do
  Signal.trap('INT')  { EventMachine.stop }
  Signal.trap('TERM') { EventMachine.stop }

  EventMachine.start_server(CONF['SOCKET_ADDRESS']['INITIAL'], CONF['SOCKET_PORT']['INITIAL'], ReseiveInitialData)
  EventMachine.start_server(CONF['SOCKET_ADDRESS']['DECRYPTED'], CONF['SOCKET_PORT']['DECRYPTED'], ReceiveDecryptedData)
end
