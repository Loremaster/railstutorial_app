This app is sample application from the book:
http://russian.railstutorial.org/chapters/static-pages.

Version 1.0.0

 - Added notification via email about new followers.
    - Added users settings about this notification.

 - Tests:
    - Added test to check functionality of notifications about new followers in 'spec/ruquests/users_spec.rb'

    - Added test for correct form of mail of notification about new followers.
      Test added in spec/mailers/user_mailer_spec.rb

 - Minor:
    - Edited view of mail about new followers to provide more information.

    - Deleted 'column notificate_about_new_followers' from user model.

    - Fixed few errors which caused by calling ramoved row from db.

------------------------------------------------------------------------------

 - Added sending notification about registration to users.

 - Also added tests for mails
    user_controller_spec updated

    user_mailer_spec updated


------------------------------------------------------------------------------

In this version after 'bundle update' i got weird errors with Rspec and strange error on server startup.

 - I fixed error on startup by adding in Gemfile

    gem 'rack', '1.3.3'

Also, i solved few exercises (2,3,4,5).