#**Version 1.1.0beta**

 - Added capistrano gem and launched application on the vds.

------------------------------------------------------------------------------

 - Added search form. It is searching microposts by default. You can search users if click link in searching results.

    - Edited few errors in tests which appeared because of new button.

 - Added search help.

------------------------------------------------------------------------------

 - Switched from sqlite to PostgreSQL. Few tests has edited because few new errors appears.

   - *HINT*: It looks like that postgre doesn't like things like that 'get 'user/1' '.
         To avoid that we can change it to form like this 'get 'user/' + user.id.to_s'

------------------------------------------------------------------------------

 - Added rss feed of user on his page (profile page).
    - Added 'views/users/show.rss.builder' to generate xml of rss feed.

    - Added link in '/views/shared/_user_info_and_stats.html.erb'

    - Tests of rss added in 'spec/requests/users_spec.rb'!

------------------------------------------------------------------------------

 - Added notification via email about new followers.
    - Added users settings about this notification.

 - Tests:
    - Added test to check functionality of notifications about new followers in 'spec/ruquests/users_spec.rb'.

    - Added test for correct form of mail of notification about new followers.
      Test added in 'spec/mailers/user_mailer_spec.rb'.

 - Minor:
    - Edited view of mail about new followers to provide more information.

    - Deleted 'column notificate_about_new_followers' from user model.

    - Fixed few errors which caused by calling ramoved row from db.

------------------------------------------------------------------------------

 - Added sending notification about registration to users.

 - Also added tests for mails:
    - 'user_controller_spec' updated.

    - 'user_mailer_spec' updated.


------------------------------------------------------------------------------

In this version after 'bundle update' i got weird errors with Rspec and strange error on server startup.

 - I fixed error on startup by adding in Gemfile:
    - gem 'rack', '1.3.3'

 - Few exercises solved (2,3,4,5).