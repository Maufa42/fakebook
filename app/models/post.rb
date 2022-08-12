# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Post < ApplicationRecord
    validates :name,:description, presence: true
    belongs_to :user
    has_many :comments
    has_many :likes
end
