require 'eventmachine'
require 'yaml'
require_relative './data_processing.rb'

Dir[File.dirname(__FILE__) + '/servers/*.rb'].each { |file| load file }

CONF = YAML.load_file('./config/config.yml')

begin
  EventMachine.run do
    EventMachine.start_server(CONF['SOCKET_ADDRESS']['INITIAL'], CONF['SOCKET_PORT']['INITIAL'], ReseiveInitialData)
    EventMachine.start_server(CONF['SOCKET_ADDRESS']['DECRYPTED'], CONF['SOCKET_PORT']['DECRYPTED'], ReceiveDecryptedData)
  end
rescue Interrupt
  puts 'Exit from EventMachine'
end