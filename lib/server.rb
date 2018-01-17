require 'socket'
require 'bindata'
require 'byebug'

# server
class Server
  attr_accessor :server_socket

  def initialize(attrs = {})
    socket_address = attrs[:socket_address]
    socket_port = attrs[:socket_port]

    @server_socket = TCPServer.open(socket_address, socket_port)
    puts 'Started server.........'
  end

  class << self
    def run(attrs = {})
      socket = new(attrs)

      loop do
        client_connection = socket.server_socket.accept
        Thread.start(client_connection) do |conn|
          send_data(conn)
        end
      end.join
    end

    def send_data(connection)
      loop do
        message = connection.gets.chomp

        # BEGIN: send response data to queue
        File.open('./tmp/test.sock', 'a') do |f|
          f.puts message
          # f << message
        end
        # END: send response data to queue

      end
    end
  end
end

Server.run(socket_address: 'localhost', socket_port: 8080)
