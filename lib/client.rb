require 'socket'
require 'byebug'

# client
class Client
  attr_accessor :socket, :message

  def initialize(message)
    @message = message
    send_request
  end

  def send_request
    tries = 3

    socket = TCPSocket.open('localhost', 8080)
    socket.puts message
    socket.close
  rescue => e
    (tries -= 1) > 0 ? retry : (puts e)
  end
end



# socket = TCPSocket.open('localhost', 8080)
# Client.new(socket)
