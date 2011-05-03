# This file is used by Rack-based servers to start the application.
require 'resque-retry'
require 'resque-retry/server'
require ::File.expand_path('../config/environment',  __FILE__)

run Stats::Application

# require 'resque/server'
# run Rack::URLMap.new \
#   "/"       => Stats::Application,
#   "/resque" => Resque::Server.new