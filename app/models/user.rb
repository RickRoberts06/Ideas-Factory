class User < ActiveRecord::Base

  has_secure_password

  has_many :ideas, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :joins, dependent: :destroy
  has_many :joined_ideas, through: :joins, source: :idea

  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    def full_name
      "#{first_name} #{last_name}".strip.squeeze(" ")
    end

  def joined_by?(user)
    joins.where(user: user).present?
  end

  def join_for(user)
    joins.find_by_user_id(user)
  end
end
