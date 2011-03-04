require 'resque'
# require 'resque/failure/hoptoad'

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

# Resque::Failure::Hoptoad.configure do |config|
#   config.api_key = 'd54e1971f80ee5ba89d354ae503ea22b'
#   config.secure = true
# 
#   # server env support, defaults to RAILS_ENV or RACK_ENV
#   config.server_environment = "production"
# end
ENV['INTERVAL'] = '3'
