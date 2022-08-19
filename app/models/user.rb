# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
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
  devise :database_authenticatable,:omniauthable,:registerable,
         :recoverable, :rememberable, :validatable
  #image
  has_one_attached :avatar, :dependent => :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy 
  has_many :likes,dependent: :destroy

  # Friend Request
  has_many :invitations
  has_many :pending_invite, -> {where confirmed: false}, class_name: "Invitation", foreign_key: "friends_id"


  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    end
    
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
    

    after_create :welcome_send
    def welcome_send
      UserMailer.welcome_email(self).deliver
      # redirect_to root_path, notice: "Thank you for Registration"
    end
end
