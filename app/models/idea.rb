class Idea < ActiveRecord::Base
  has_many :comment, dependent: :destroy
  belongs_to :user

  has_many :joins, dependent: :destroy
  has_many :joining_users, through: :joins, source: :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  def joined_by?(user)
    joins.where(user: user).present?
 end

 def join_for(user)
   joins.find_by_user_id(user)
 end

 def liked_by?(user)
   likes.where(user: user).present?
 end

 def like_for(user)
   likes.find_by_user_id(user)
 end

   # def idea_from?(user)
   #   ideas.where(user: user).present?
   # end

end
