class AddNotificationAboutNewFollowersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification_about_new_followers, :boolean, 
                                                          :default => true
  end
end
