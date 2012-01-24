require 'bundler/capistrano'

set :user, "root"                                                             #If you log into your server with a different user name than you are logged into your local machine with, you’ll need to tell Capistrano about that user name.
set :rails_env, "production"

set :application, "ror_tutorial"
set :deploy_to, "/vol/www/apps/#{application}"

set :scm, :git
set :repository,  "git://github.com/Loremaster/sample_app.git"
set :branch, "master"
set :deploy_via, :remote_cache
default_run_options[:pty] = true                                              #Must be set for the password prompt from git to work#Keep cash of repository locally and with ney deploy get only changes.


server "188.127.224.136", :app,                                               # This may be the same as your `Web` server
                          :web,
                          :db, :primary => true                               # This is where Rails migrations will run


#namespace :passenger do
#  desc "Restart Application"
#  task :restart do
#    run "touch #{current_path}/tmp/restart.txt"
#  end
#end
#
#after :deploy, "passenger:restart"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end