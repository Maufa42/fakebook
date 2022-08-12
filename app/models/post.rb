class Post < ApplicationRecord
    validates :name,:description, presence: true
end
