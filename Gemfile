source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'gravatar_image_tag'
gem 'will_paginate'
gem 'rack', '1.3.3'


# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

group :development do
  gem 'rspec-rails', '2.6.1'
  gem 'therubyracer-heroku'
  gem 'sqlite3'                                                               #Without this gem autotest doesn't work. I use it in development only because of Heroku.
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'        #It is patched version from github. This one works.
  #gem 'rack-ssl'
  gem 'faker'                                                                 #automating filling db by test data.
end

group :test do
  gem 'rspec-rails', '2.6.1'
  gem 'webrat', '0.7.1'
  gem 'spork'
  gem 'autotest'
  gem 'autotest-rails-pure'
  gem 'autotest-fsevent'
  gem 'autotest-growl'
  gem 'factory_girl_rails'
end

group :production do  
  gem 'pg'                                                                    #this gem uses with heroku
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

