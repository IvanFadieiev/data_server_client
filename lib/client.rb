require 'socket'
require 'openssl'

# Client
class Client
  attr_accessor :socket_address, :socket_port, :tries

  def initialize(attrs = {})
    @socket_address = attrs[:socket_address]
    @socket_port = attrs[:socket_port]
    @tries = 3
  end

  def send_message(message)
    ssl_context = OpenSSL::SSL::SSLContext.new()
    ssl_context.cert = OpenSSL::X509::Certificate.new(File.open("./tmp/server.crt"))
    ssl_context.key = OpenSSL::PKey::RSA.new(File.open("./tmp/server.key"))
    ssl_context.ssl_version = :SSLv23
    ssl_socket = OpenSSL::SSL::SSLSocket.new(client, ssl_context)
    ssl_socket.sync_close = true
    ssl_socket.connect
    ssl_socket.print(message)
    ssl_socket.close
  rescue => e
    (@tries -= 1) > 0 ? retry : e
  end

  private

  def client
    TCPSocket.open(socket_address, socket_port)
  end
end
