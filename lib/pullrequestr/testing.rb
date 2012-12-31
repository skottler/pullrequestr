module Pullrequestr
  class Testing
    require 'uri'
    require 'net/http'
    require 'net/https'

    def self.load_config(configuration_path)
      begin
        config = YAML.load_file(configuration_path)
        @gh_user = config['user']
        @gh_repo = config['repository']
        @comment_un = config['comment_user']
        @comment_password = config['comment_password']
      rescue Exception => e
        puts e.message
        exit(1)
      end
    end

    def self.run(options = {}, headers = {})
      uri = URI.parse("https://api.github.com/repos/#{@gh_user}/#{@gh_repo}/pulls")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri, headers)
      request.basic_auth @comment_un, @comment_password
      response = http.request(request)
      puts response.body
    end
  end

  def self.test
  end

  def self.comment(status = true)
    comment = {}

    if status == true
      comment[:body] = "The build passed"
    else
      comment[:body] = "The build failed"
    end
  end
end
