require 'socket'

# Client
class Client
  attr_accessor :socket_address, :socket_port, :tries

  def initialize(attrs = {})
    @socket_address = attrs[:socket_address]
    @socket_port = attrs[:socket_port]
    @tries = 3
  end

  def send_message(message)
    client.print(message)
    client.close
  rescue => e
    (@tries -= 1) > 0 ? retry : e
  end

  private

  def client
    TCPSocket.open(socket_address, socket_port)
  end
end
