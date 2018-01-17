require 'socket'
require 'byebug'

# server
class Server
  attr_accessor :server_socket, :connections_details, :connected_clients

  def initialize(socket_address, socket_port)
    @server_socket = TCPServer.open(socket_address, socket_port)
    @connections_details = Hash.new
    @connected_clients = Hash.new
    @connections_details[:server] = server_socket
    @connections_details[:clients] = @connected_clients
    puts 'Started server.........'
  end

  def run
    loop {
      client_connection = server_socket.accept
      Thread.start(client_connection) do |conn|
        conn_name = conn.gets.chomp.to_sym
        if (connections_details[:clients][conn_name] != nil)
          conn.puts 'This username already exist'
          conn.puts 'quit'
          conn.kill self
        end

        puts "Connection established #{conn_name} => #{conn}"
        connections_details[:clients][conn_name] = conn
        conn.puts "Connection established successfully #{conn_name} => #{conn}, you may continue with chatting....."

        establish_chatting(conn_name, conn) # allow chatting
      end
    }.join
  end

  def establish_chatting(username, connection)
    loop do
      message = connection.gets.chomp
      puts connections_details[:clients]
      (connections_details[:clients]).keys.each do |client|
        connections_details[:clients][client].puts "#{username} : #{message}"
      end
    end
  end
end


Server.new('localhost', 8080).run
