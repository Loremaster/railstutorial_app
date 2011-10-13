class AddNotificateAboutFollowers < ActiveRecord::Migration
  def change
    remove_column :users, :notification_about_new_followers
    add_column :users, :notification_about_new_followers, :boolean,
                                                          :default => true
  end
end
