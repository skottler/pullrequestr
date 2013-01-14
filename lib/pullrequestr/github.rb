module Pullrequestr
  class Github
    require 'uri'
    require 'json'
    require 'rest-client'

    attr_accessor :comment_un, :comment_password, :gh_repo, :gh_repo

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

    # Accepts a PR number and checks against the pullrequests.csv file to see
    # whether tests have been run against a specific PR.
    def self.has_been_run?(number)
      begin
        pullrequests = CSV.open('pullrequests.csv', 'r') do |pr|
          if pr == number
            true
          else
            false
          end
        end
        pullrequests.close
      rescue Exception
        false
      end
    end

    # Run through all the open pull requests that haven't yet been tested
    # via Jenkins.
    def self.run()
      uri = "https://api.github.com/repos/#{@gh_user}/#{@gh_repo}/pulls"
      prs = JSON.parse(RestClient.get(uri))
      for pr in prs
        if pr['state'] == 'open'
          if has_been_run?(pr['number'])
            puts "#{pr['number']} has already been tested. Skipping..."
          else
            puts "#{pr['number']} hasn't been tested. Starting a test run..."
          end
        end
      end
    end
  end

  # This method comments on Github issues with the jenkins build number, a line
  # about whether the build passed, etc. The sole parameter is a boolean
  # of the build status - true for pass, false for failure.
  def self.comment(status = true)
    comment = {}

    if status[:success] == true
      comment[:body] = "The build passed"
    else
      comment[:body] = "The build failed"
    end
  end
end
