require_relative '../lib/client.rb'
require 'rack'
require 'rack/response'
require 'yaml'
require 'byebug'

CONF = YAML.load_file('./config/config.yml')

# SocketClientRun
class SocketClientRun
  PATHS = { send_data: '/send_initial_data' }.freeze

  def call(env)
    req = Rack::Request.new(env)

    case req.path_info
    when PATHS[:send_data]
      client_send_msg(req.params['message']).tap do |response|
        raise response.message if response&.errno
      end
      response_data(200, 'data were sent')
    else
      raise 'Route doesn`t exist'
    end
  rescue => e
    response_data(500, e.to_s)
  end

  private

  def client
    Client.new(socket_address: CONF['SOCKET_ADDRESS']['INITIAL'],
               socket_port: CONF['SOCKET_PORT']['INITIAL'])
  end

  def client_send_msg(msg)
    client.send_message(msg)
  end

  def response_data(code, msg, headers: {})
    [code, headers, [msg]]
  end
end

run SocketClientRun.new
