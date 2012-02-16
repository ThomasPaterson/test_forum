class Topic < ActiveRecord::Base
  attr_accessible :name, :last_poster_id, :last_post_at, :forum_id, :user_id, :id
  belongs_to :forum
  belongs_to :user
  has_many :posts, :dependent => :destroy

  accepts_nested_attributes_for :posts
end
