# ReseiveInitialData
module ReseiveInitialData
  def post_init
    start_tls(private_key_file: './tmp/server.key',
              cert_chain_file: './tmp/server.crt',
              verify_peer: false)
  end

  def receive_data data
    # send_data ">>>you sent: #{data}"
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
