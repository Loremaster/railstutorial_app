This app is sample application from the book:
http://russian.railstutorial.org/chapters/static-pages.

Version 1.0.0

TODO: Write tests for users notification. And understand how remove table users_preferenses
and column notificate_about_new_followers.

 - Added notification via email about new followers.
    Added users settings about this notification.

 - Added test for correct form of mail of notification about new followers.
    Test added in spec/mailers/user_mailer_spec.rb

 - Minor: deleted 'column notificate_about_new_followers' from user model.

------------------------------------------------------------------------------

 - Added sending notification about registration to users.

 - Also added tests for mails
    user_controller_spec updated

    user_mailer_spec updated


------------------------------------------------------------------------------

In this version after 'bundle update' i got weird errors with Rspec and strange error on server startup.

 - I fixed error on startup by adding in Gemfile

    gem 'rack', '1.3.3'

 - Sourse of weird errors in Rspec is unknown. I suppose that it is newest version of Rspec. So, i edited tests to
  pass my tests but i still don't know what to do.

Also, i solved few exercises (2,3,4,5).