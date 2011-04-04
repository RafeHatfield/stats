require 'redis/set'
class Writer
  include Singleton
  attr_accessor :writer_ids
  
  def initialize
    redis  = Redis.new(:host => 'localhost', :port => 6379)
    @writer_ids  = Redis::Set.new('writer_ids', redis)
  end
  
  def exists?(writer_id)
    @writer_ids.member?(writer_id)
  end
end