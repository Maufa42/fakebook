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
class Invitation < ApplicationRecord
  belongs_to :user


  def self.confirmed_record?(id1,id2)
    case1 = !Invitation.where(user_id: id1, friends_id: id2, confirmed: true).empty?
    case2 = !Invitation.where(user_id: id2, friends_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.reacted?(id1,id2)
    case1 = !Invitation.where(user_id: id1, friends_id: id2).empty?
    case2 = !Invitation.where(user_id: id2, friends_id: id1).empty?
    case1 || case2
  end

end
