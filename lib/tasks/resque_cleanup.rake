require 'rubygems'
require 'progressbar'
require 'resque'

namespace :resque do
  desc "Retry the failed jobs"
  task :cleanup_failures do
    redis = Resque.redis
    total_count = Resque::Failure.backend.count

    pbar = ProgressBar.new("Cleaning up...", 100)
    count = 0
    running = 5000.to_f
    
    Resque::Failure.all(0, running).each_with_index do |failure, index|
      case failure['exception'] 
      when 'ActiveRecord::RecordInvalid'
        value = redis.lindex(:failed, index)
        redis.lrem(:failed, 1, value)
      when 'MemCache::MemCacheError'
        Resque::Failure.backend.requeue(index)
        value = redis.lindex(:failed, index)
        redis.lrem(:failed, 1, value)
      else
        
      end
      percentage = (index/running).to_f * 100
      pbar.set percentage
    end
    
    pbar.finish
  end  


  desc "Clean up retried jobs"
  task :cleanup_retries => :environment do
    redis = Resque.redis
    total_count = Resque::Failure.backend.count
    
    pbar = ProgressBar.new("Cleaning up retries...", 100)
    count = 0
    running = 1000.to_f
  
    Resque::Failure.all(0, running).each_with_index do |failure, index|
      if failure['retried_at'].present?
        value = redis.lindex(:failed, index)
        redis.lrem(:failed, 1, value)
      end
      percentage = index/running * 100
      pbar.set percentage
    end  
    
    pbar.finish
  end
end