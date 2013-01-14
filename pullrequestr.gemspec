require File.expand_path('../lib/pullrequestr/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'pullrequestr'
  s.version     = Pullrequestr::VERSION
  s.date        = '2012-11-24'
  s.summary     = "Test pull requests"
  s.description = "Test Github pull requests with Jenkins"
  s.authors     = ["Sam Kottler"]
  s.email       = 'sam@kottlerdevelopment.com'
  s.files       = %w( README.md LICENSE )

  s.add_dependency 'rest-client'

  s.files       += Dir.glob("lib/**/*")
  s.files       += Dir.glob("bin/**/*")
  s.executables = %w( pullrequestr )

  s.post_install_message = <<-message

------------------------------------------------------------

     Ensure you create a .pullrequestr.yml in $HOME

------------------------------------------------------------

message
end
