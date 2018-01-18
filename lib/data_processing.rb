# DataProcessing
class DataProcessing
  class << self
    def call(message)
      # TODO: change next lines to logic which sending the data to queue
      # BEGIN: send response data to queue
      File.open('./tmp/sockets/initial_data.sock', 'a') do |f|
        f.puts message
      end
      # END: send response data to queue
    end
  end
end
