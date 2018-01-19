require 'byebug'
# ReseiveInitialData
class ReseiveInitialData < EventMachine::Connection
  def post_init
    puts 'connected' unless ENV['APP_ENV'].eql?('production')
    set_sock_opt(Socket::SOL_SOCKET, Socket::SO_KEEPALIVE, true)
    set_sock_opt(Socket::SOL_TCP, Socket::TCP_KEEPIDLE, 10) # 50
    set_sock_opt(Socket::SOL_TCP, Socket::TCP_KEEPINTVL, 10)
    set_sock_opt(Socket::SOL_TCP, Socket::TCP_KEEPCNT, 5)
  end

  def receive_data(data)
    puts 'disconnected' unless ENV['APP_ENV'].eql?('production')
    # send_data ">>>you sent: #{data}"
    byebug
    if data.eql?('quit')
      EventMachine.stop_event_loop
    else
      DataProcessing.call(data)
    end
  end

  # def unbind
  # puts "-- someone disconnected from the echo server!"
  # end
end


# data.unpack("B*")[0][0...3*8].scan(/.{1,8}/).map { |part|  part.to_i(2).chr }.join