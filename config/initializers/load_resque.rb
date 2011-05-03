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

# Workers sleep for 3 seconds (default is 5 seconds)
ENV['INTERVAL'] = '3'
# 
# Workers work on more jobs before suicide. See death notes at https://github.com/staugaard/resque-multi-job-forks
ENV['MINUTES_PER_FORK'] = '5'
