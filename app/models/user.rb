class User < ApplicationRecord
  validates :full_name, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :techbits, foreign_key: :author_id, dependent: :destroy
  has_one_attached :photo
  has_one_attached :coverimage

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Following'
  has_many :followeds, through: :followed_users
  has_many :following_users, foreign_key: :followed_id, class_name: 'Following'
  has_many :followers, through: :following_users

  def follow(user)
    followed_users.create(followed_id: user.id)
    #   following.create({ followed_id: user.id }) unless follows?(user)
  end

  def unfollow(user)
    followed_users.where({ followed_id: user.id }).destroy_all
  end

  def post(content)
    opinions.create({ text: content })
  end

  def follows?(user)
    followed_users.where(followed_id: user.id).exists?
  end

  def followers_ids
    followers.select('follower_id').pluck('follower_id').to_a
  end

  def followings_ids
    followings.select('followed_id').pluck('followed_id').to_a
  end

  private

  def destroy_relations
    followers.destroy_all
    followings.destroy_all
    opinions.destroy_all
  end
end
