set :application, "ror_tutorial"
set :repository,  "git@github.com:Loremaster/sample_app.git"
set :deploy_to, "/vol/www/apps/#{application}"

set :user, "root"                                                             #If you log into your server with a different user name than you are logged into your local machine with, you’ll need to tell Capistrano about that user name.


set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your host"                          # Your HTTP server, Apache/etc
#role :app, "your host"                          # This may be the same as your `Web` server
#role :db,  "your host", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

server "188.127.224.136", :app, :web, :db, :primary => true


namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end