# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  confirmed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :integer
#  user_id    :integer
#
require "test_helper"

class FriendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
