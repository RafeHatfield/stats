require 'resque'
require 'resque/failure/hoptoad'

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

Resque::Failure::Hoptoad.configure do |config|
  config.api_key = 'f74b704cec57994aafd27e544513573accdf8824'
  config.secure = true

  # server env support, defaults to RAILS_ENV or RACK_ENV
  config.server_environment = "production"
end
