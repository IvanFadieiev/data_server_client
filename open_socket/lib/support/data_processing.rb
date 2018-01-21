# DataProcessing
class DataProcessing
  class << self
    def call(message)
      # BEGIN: send response data to queue
      File.open('./open_socket/tmp/initial_data.txt', 'a') do |f|
        f.puts message
      end
      # END: send response data to queue
      conn = Bunny.new(host: CONF['QUEUE']['INITIAL']['HOST'],
                       port: CONF['QUEUE']['INITIAL']['PORT'],
                       user: CONF['QUEUE']['INITIAL']['USER'],
                       password: CONF['QUEUE']['INITIAL']['PASS'])
      conn.start
      channel = conn.create_channel
      queue = channel.queue(CONF['QUEUE']['INITIAL']['NAME'],
                            auto_delete: true,
                            durable: true)
      x = channel.default_exchange
      x.publish(message, routing_key: queue.name, persistent: false)
      conn.close
    end
  end
end
