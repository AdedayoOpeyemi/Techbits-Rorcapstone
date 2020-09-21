class User < ApplicationRecord

    has_many :techbits, foreign_key: :author_id
end
