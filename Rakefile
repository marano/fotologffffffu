require './fotologffffffu'

desc "This task is called by the Heroku cron add-on"
task :cron do
  cache = Dalli::Client.new('localhost:11211')
  users = cache.get 'recent_users'
  log = Logger.new(STDOUT)
  log.debug users
  users.each do |user|
    log.debug cache.get user
    print "User successfully updated: #{user}" if Fotolog.new(user).update_cache
  end
end

