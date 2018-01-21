# CreatePid
class CreatePid
  class << self
    def for(pid: nil, file: nil)
      File.open(pid_file(file), 'w') { |f| f.write pid }
    end

    private

    def pid_name(file)
      File.basename(file).gsub('.rb', '').gsub('.ru', '')
    end

    def pid_file(file)
      "tmp/pids/#{pid_name(file)}.pid"
    end
  end
end
