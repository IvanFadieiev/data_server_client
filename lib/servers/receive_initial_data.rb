# ReseiveInitialData
module ReseiveInitialData
  # def post_init
  # puts "-- someone connected to the echo server!"
  # end

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
