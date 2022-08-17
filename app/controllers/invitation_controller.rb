class InvitationController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.select(:id,:name,:email).where.not(id: current_user[:id])
    @user = current_user
    # @user = User.find_by(params[:id])
    @pending = @user.pending_invite
    @friends = Invitation.all.select{ |m| m.confirmed == true || (m.user_id == @user.id || m.friends_id == @user.id)}
    # debugger
    # @friends = Invitation.select(id: current_user.id,confirmable: true)
  end

  def new
  end

  def create
    @invitation = current_user.invitations.create(invite_params)
    if @invitation.save
      redirect_to root_path
    else
      render all_user_path
    end
  end

  def accept
    @invitation = Invitation.find(params[:id])
    accept = @invitation.update(invite_params)
  end

  private

  def invite_params
    params.permit(:friends_id,:confirmed)
  end

end
