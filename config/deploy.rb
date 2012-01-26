#Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

#Load RVM's capistrano plugin.    
require "rvm/capistrano"
require 'bundler/capistrano'
#require 'thinking_sphinx/deploy/capistrano'

set :rvm_ruby_string, '1.9.3-head'                                            #This is current version of ruby which is uses by RVM. To get version print: $ rvm list 
set :rvm_type, :root                                                          #Don't use system-wide RVM, use my user, which name is root.

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

# task :before_update_code, :roles => [:app] do
#   run "cd #{current_path} rake thinking_sphinx:stop"
# end

#New config for start server
# task :after_update_code, :roles => [:app] do
#   run "cd #{current_path} rake thinking_sphinx:index && rake thinking_sphinx:configure && rake thinking_sphinx:start"
# end

desc "Prepare system"
  task :prepare_system, :roles => :app do
    run "cd #{current_path} && bundle install --without development test && bundle install --deployment"
  end
  
#chmod doesn't work, why?
# desc "Fix permission"
#   task :fix_permissions, :roles => :app do
#     run "sudo chmod 777 -R #{current_path}/tmp/" 
#   end
    
  after "deploy:update_code", :prepare_system
  # after "deploy:update_code", :fix_permissions
