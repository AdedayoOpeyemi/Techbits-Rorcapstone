class User < ApplicationRecord
    validates :full_name, presence: true
    validates :username, presence: true, uniqueness: true

    has_many :techbits, foreign_key: :author_id
    has_one_attached :photo
    has_one_attached :coverimage

    has_many :followed_users, foreign_key: :follower_id, class_name: 'Following'
    has_many :followeds, through: :followed_users
    has_many :following_users, foreign_key: :followed_id, class_name: 'Following'
    has_many :followers, through: :following_users
end
