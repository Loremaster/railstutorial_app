#require 'bundler/capistrano'

set :user, "root"                                                             #If you log into your server with a different user name than you are logged into your local machine with, you’ll need to tell Capistrano about that user name.

set :rails_env, "production"

default_run_options[:pty] = true                                              # Must be set for the password prompt from git to work
set :repository,  "git://github.com/Loremaster/sample_app.git"

set :application, "ror_tutorial"
set :deploy_to, "/vol/www/apps/#{application}"

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache                                                # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.
#role :web, "your host"                          # Your HTTP server, Apache/etc
#role :app, "your host"                          # This may be the same as your `Web` server
#role :db,  "your host", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

server "188.127.224.136", :app,
                          :web,
                          :db, :primary => true


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