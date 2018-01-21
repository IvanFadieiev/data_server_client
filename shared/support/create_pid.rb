# CreatePid
class CreatePid
  class << self
    def for(pid: nil, file: nil, dir: nil)
      File.open(pid_file(file, dir), 'w') { |f| f.write pid }
    end

    private

    def pid_name(file)
      File.basename(file).gsub('.rb', '').gsub('.ru', '')
    end

    def pid_file(file, dir)
      "./#{dir}/tmp/pids/#{pid_name(file)}.pid"
    end
  end
end
