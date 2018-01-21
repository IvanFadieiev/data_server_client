require 'yaml'
require_relative '../../../shared//support/create_pid.rb'

CONF = YAML.load_file('./shared/config/config.yml') # check this line

# RunServer
class RunServer
  attr_reader :process, :file, :host, :port, :handler

  def initialize(attrs = {})
    @process = attrs[:process]
    @file = attrs[:file]
    @host = attrs[:host]
    @port = attrs[:port]
    @handler = attrs[:handler]
  end

  class << self
    def execute(attrs = {})
      obj = new(attrs)
      obj.daemonize if ENV['APP_ENV'].eql?('production')
      obj.create_pid
      obj.run_server
    end
  end

  def daemonize
    process.daemon(true, true)
  end

  def create_pid
    CreatePid.for(file: file, pid: process.pid, dir: 'open_socket')
  end

  def run_server
    EventMachine.run do
      Signal.trap('INT')  { EventMachine.stop }
      Signal.trap('TERM') { EventMachine.stop }

      EventMachine.start_server(host, port, handler)
    end
  end
end
