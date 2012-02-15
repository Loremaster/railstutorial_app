# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


set :output, "/vol/www/apps/logs/cron_log.log"                                #Log for production.

every 5.minutes do
#  command "echo 'Thinking sphinx - starting indexing'"
  rake "thinking_sphinx:index RAILS_ENV=production"
  rake "thinking_sphinx:rebuild RAILS_ENV=production"
  command "chmod 777 -R /vol/www/apps/ror_tutorial/current/log/"              #Fixing losing permissions for log/ folder
end




