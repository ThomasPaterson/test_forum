class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id, :user_id
  validates_presence_of :topic

  belongs_to :topic
  belongs_to :user
end
