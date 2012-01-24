# Created by 'bundle exec annotate --position before'
# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content                                                    # ONLY content can be edited by user.
  belongs_to      :user                                                       # Micropost belongs to user.
  default_scope   :order => 'microposts.created_at DESC'                      # Ordering posts by date of creation. DESC is SQL for “descending”.
  
  # Return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  validates :content, :presence => true, :length => { :maximum => 140 }       # Content of message should be and max 140 symbols.
  validates :user_id, :presence => true                                       # User id should be being.

  define_index do
    indexes content
  end


  private

      # Return an SQL condition for users followed by the given user.
      # We include the user's own id as well.
      def self.followed_by(user)
        following_ids = %(SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id)
        where("user_id IN (#{following_ids}) OR user_id = :user_id",
              { :user_id => user })
      end
end
