require 'bunny'
require 'eventmachine'
require 'yaml'
require_relative '../../shared/support/create_pid'
require 'byebug'

CONF = YAML.load_file('./shared/config/config.yml')

CreatePid.for(file: __FILE__, pid: Process.pid, dir: 'initial_queue')

EventMachine.run do
  @conn = Bunny.new(host: CONF['QUEUE']['INITIAL']['HOST'],
                    port: CONF['QUEUE']['INITIAL']['PORT'],
                    user: CONF['QUEUE']['INITIAL']['USER'],
                    password: CONF['QUEUE']['INITIAL']['PASS'])
  @conn.start

  channel = @conn.create_channel
  queue = channel.queue(CONF['QUEUE']['INITIAL']['NAME'],
                        auto_delete: true,
                        durable: true)

  EM.tick_loop do
    queue.subscribe do |delivery_info, metadata, payload|
      # TODO: get data from initial queue and handle them
      byebug
      puts "Received to #{metadata}"
      # TODO: get data from initial queue and handle them
    end
  end

  Signal.trap('INT') do
    EM.add_timer(0) do
      puts 'initial queue closed' unless ENV['APP_ENV'].eql?('production')
      @conn.close if @conn.status.eql?(:open)
    end
    EventMachine.stop
  end

  Signal.trap('TERM') do
    EM.add_timer(0) do
      puts 'initial queue closed' unless ENV['APP_ENV'].eql?('production')
      @conn.close if @conn.status.eql?(:open)
    end
    EventMachine.stop
  end
end
