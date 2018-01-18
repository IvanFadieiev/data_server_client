require 'socket'

# Client
class Client
  attr_accessor :socket_address, :socket_port, :tries, :sent, :errors

  def initialize(attrs = {})
    @socket_address = attrs[:socket_address]
    @socket_port = attrs[:socket_port]
    @errors = []
    @sent = false
    @tries = 3
  end

  def send_message(message)
    return self if inappropriate_condition?(message)
    begin
      client.print(message)
      self.sent = true
      client.close
    rescue => e
      if (@tries -= 1) > 0
        retry
      else
        errors << e
      end
    end
    self
  end

  private

  def client
    TCPSocket.open(socket_address, socket_port)
  end

  def inappropriate_condition?(message)
    message.nil? || message.empty?
  end
end
