require './client'
require 'rack'
require 'rack/response'
require 'byebug'

class SocketClientRun
  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
      when /send_data/
        socket = TCPSocket.open('localhost', 8080)
        message = req.params['message']
        Client.new(socket, message)
        [200, {}, ['data were sent']]
      else
        raise 'Route don`t exist'
    end
  rescue => e
    [500, {}, [e.to_s]]
  end
end

# Rack::Handler.default.run(SocketClientRun.new, :Port => 1234)

run SocketClientRun.new