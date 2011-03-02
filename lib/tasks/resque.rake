# Include the tasks defined by resque.
require 'resque/tasks'

# Load the rails environment each time a worker is spawned.
task "resque:setup" => :environment do
  ActiveRecord::Base.send(:subclasses).each { |klass|  klass.columns }
end