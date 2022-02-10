class UsersController < ApplicationController
  layout "dashboard"
  def edit
    @user = Information.where(user_id: current_user.id)
  end

  def update
    @user = Information.where(user_id: current_user.id)
    # @user.update(params)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
