# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts
  has_many :comments, dependent: :destroy 
  has_many :likes,dependent: :destroy

  # Friend Request
  has_many :invitations
  has_many :pending_invite, -> {where confirmed: false}, class_name: "Invitation", foreign_key: "friends_id"

    def friends
      friend_i_sent = Invitation.where(user_id: id, confirmed: true).pluck(:friends_id)
      friend_i_got = Invitation.where(friends_id:id,confirmed: true).pluck(:user_id)
  
      ids = friend_i_sent + friend_i_got
      User.where(id: ids)
    end

    def friend_with?(user)
      Invitation.confirmed_record?(id,user.id)
    end

    def send_invitation(user)
      invitations.create(friends_id: user.id  )
    end

end
