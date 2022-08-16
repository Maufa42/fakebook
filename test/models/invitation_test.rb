# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  confirmed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friends_id :integer
#  user_id    :integer          not null
#
# Indexes
#
#  index_invitations_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
