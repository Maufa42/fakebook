class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:id])

  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_image)
      redirect_to root_path
    end
  end

  private

  def params_image
    params.require(:user).permit(:avatar)
  end

end
