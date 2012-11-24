module Pullrequestr
  class Testing
    def self.load_config(configuration_path)
      begin
        config = YAML.load_file(configuration_path)
        @gh_user = config['user']
        @gh_repo = config['repository']
      rescue Exception => e
        puts e.message
        exit(1)
      end
    end

    def self.run(options = {}) 
      pulls = HTTParty.get("https://api.github.com/repos/#{@gh_user}/#{@gh_repo}/pulls")
      puts pulls.body.inspect
    end
  end
end
