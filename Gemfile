source 'http://rubygems.org'

gem 'rails', '3.1.3'                                                          #'3.1.0'
gem 'gravatar_image_tag'
gem 'will_paginate'
gem 'rack'
gem 'rake'                                                                              #'1.3.3'
gem 'texticle', "2.0", :require => 'texticle/rails'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'                                                            #, "~> 3.1.0"
  gem 'coffee-rails'                                                          #, "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

group :development do
  gem 'capistrano'
  gem 'rspec-rails'                                                           #, '2.6.1'
  gem 'therubyracer-heroku'
  gem 'pg'                                                                    #'sqlite3' - prev   
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'        #It is patched version from github. This one works.
  #gem 'rack-ssl'
  gem 'faker'                                                                 #automating filling db by test data.
end

group :test do
  gem 'rspec-rails'                                                           #, '2.6.1'
  gem 'webrat'                                                                #, '0.7.1'
  gem 'spork'
  gem 'autotest'                                                              #, '4.4.6'                                                
  gem 'autotest-rails-pure'                                                   #, '4.1.2'                                                
  gem 'autotest-fsevent'                                                      #, '0.2.4'                                                 
  gem 'autotest-growl'                                                        #,'0.2.9'                                                  
  gem 'factory_girl_rails'
end

group :production do  
  gem 'pg'                                                                    #postgre gem (uses with heroku)
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

