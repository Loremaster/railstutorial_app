class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false                    #:default => false means that user is NOT admin by default. 
  end

  def self.down
    remove_column :users, :admin
  end
end
