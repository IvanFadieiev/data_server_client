# ReceiveDecryptedData
module ReceiveDecryptedData
  def receive_data data
    if data.eql?('quit')
      EventMachine.stop_event_loop
    else
      DataProcessing.call(data)
    end
  end
end
