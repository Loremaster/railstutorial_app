This app is sample application from the book:
http://russian.railstutorial.org/chapters/static-pages.

Version 1.0.0

In this version after 'bundle update' i got weird errors with Rspec and strange error on server startup.

 - I fixed error on startup by adding in Gemfile

    gem 'rack', '1.3.3'

 - Sourse of weird errors in Rspec is unknown. I suppose that it is newest version of Rspec. So, i edited tests to
  pass my tests but i still don't know what to do.

Also, i solved few exercises (2,3,4,5).