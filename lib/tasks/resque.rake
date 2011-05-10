# Include the tasks defined by resque.
require 'resque/tasks'
require 'resque-cleaner'

# Load the rails environment each time a worker is spawned.
task "resque:setup" => :environment do
  ActiveRecord::Base.send(:subclasses).each { |klass|  klass.columns }
end

def run_worker(queue, count = 1)
  puts "Starting #{count} worker(s) with QUEUE: #{queue}"
  ops = {:pgroup => true, :err => [(Rails.root + "log/resque_err").to_s, "a"], 
                          :out => [(Rails.root + "log/resque_stdout").to_s, "a"]}
  env_vars = {"QUEUE" => queue.to_s}
  count.times {
    ## Using Kernel.spawn and Process.detach because regular system() call would
    ## cause the processes to quit when capistrano finishes
    pid = spawn(env_vars, "rake resque:work", ops)
    Process.detach(pid)
  }
end

namespace :resque do
  task :setup => :environment

  desc "Restart running workers"
  task :restart_workers => :environment do
    Rake::Task['resque:stop_workers'].invoke
    Rake::Task['resque:start_workers'].invoke
  end
  
  desc "Quit running workers"
  task :stop_workers => :environment do
    pids = Array.new
    Resque.workers.each do |worker|
      pids.concat(worker.worker_pids)
    end
    if pids.empty?
      puts "No workers to kill"
    else
      syscmd = "kill -s QUIT #{pids.join(' ')}"
      puts "Running syscmd: #{syscmd}"
      system(syscmd)
    end
  end
  
  desc "Start workers"
  task :start_workers => :environment do
    run_worker("*", 6)
    run_worker("high", 1)
  end
  
  desc "Retry the failed jobs"
  task :retry_jobs => :environment do
    redis = Resque.redis
    count = Resque::Failure.backend.count
    
    Resque::Failure.all(0, 100).each_with_index do |failure, index|
      if failure['exception'] =~ /ActiveRecord::RecordInvalid/
        value = redis.lindex(:failed, index)
        redis.lrem(:failed, 1, value)
      # elsif failure['exception'] =~ //
      #   
      end
    end
  end  
end
