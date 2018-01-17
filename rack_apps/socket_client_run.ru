require './lib/client'
require 'rack'
require 'rack/response'
require 'byebug'

class SocketClientRun
  PATHS = { send_data: '/send_data' }.freeze

  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
      when PATHS[:send_data]
        client_call(req.params['message'])
        response_data(200, 'data were sent')
      else
        raise 'Route doesn`t exist'
    end
  rescue => e
    response_data(500, e.to_s)
  end

  private

  def client_call(msg)
    Client.new(msg)
  end

  def response_data(code, msg, headers: {})
    [code, headers, [msg]]
  end
end

# Rack::Handler.default.run(SocketClientRun.new, :Port => 1234)

run SocketClientRun.new