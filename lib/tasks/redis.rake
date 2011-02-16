namespace :redis do
  desc 'Start redis server according to the environment'
  task :start do
    if RAILS_ENV=='test'
      sh "redis-server config/redis/test.conf"
    else
      sh "redis-server config/redis/development.conf"
    end
  end
end