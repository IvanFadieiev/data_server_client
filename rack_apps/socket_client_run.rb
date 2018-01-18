require_relative '../lib/client.rb'
require 'yaml'
require 'byebug'

CONF = YAML.load_file('./config/config.yml')

# SocketClientRun
class SocketClientRun
  PATHS = { send_data: '/send_initial_data' }.freeze

  class << self
    def call(env)
      msg = params(env)['message']
      current_client = client_send_msg(msg)
      handle_errors(current_client)
      handle_response(current_client)
    end

    private

    def request(env)
      Rack::Request.new(env)
    end

    def params(env)
      request(env).params
    end

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

    def handle_errors(client)
      raise client.errors.map(&:message).join(', ') if client.errors.any?
    end

    def handle_response(client)
      if client.sent
        response_data(200, 'data were sent')
      else
        response_data(500, 'without data')
      end
    end
  end
end