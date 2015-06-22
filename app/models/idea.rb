class Idea < ActiveRecord::Base
  has_many :comment, dependent: :destroy
  belongs_to :user

  has_many :joins, dependent: :destroy
  has_many :joining_users, through: :joins, source: :user

  def joined_by?(user)
   joins.where(user: user).present?
 end

 def join_for(user)
   joins.find_by_user_id(user)
 end

end
