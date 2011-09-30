class Micropost < ActiveRecord::Base
  attr_accessible :content                                                    # ONLY content can be edited by user.
  belongs_to      :user                                                       # Micropost belongs to user.
  default_scope   :order => 'microposts.created_at DESC'                      # Ordering posts by date of creation. DESC is SQL for “descending”.
  
  validates :content, :presence => true, :length => { :maximum => 140 }       # Content of message should be and max 140 symbols.
  validates :user_id, :presence => true                                       # User id should be being.
end
