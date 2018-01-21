require 'eventmachine'
require_relative '../support/run_server.rb'
load File.dirname(__FILE__) + '/../em_handlers/receive_initial_data.rb'

RunServer.execute(process: Process,
                  file: __FILE__,
                  host: CONF['SOCKET_ADDRESS']['INITIAL_SECOND'],
                  port: CONF['SOCKET_PORT']['INITIAL_SECOND'],
                  handler: ReseiveInitialData)
