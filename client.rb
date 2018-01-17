require 'socket'

# client
class Client
  attr_accessor :socket, :message

  def initialize(socket, message)
    @socket = socket
    @message = message
    send_request
  end

  def send_request
    socket.puts message
    socket.close
  end
end



# socket = TCPSocket.open('localhost', 8080)
# Client.new(socket)
