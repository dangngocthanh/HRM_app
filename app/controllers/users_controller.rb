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
    authorize @users
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy

    authorize User.none

    user = User.find(params[:id])

    user.projects.where(user_id: user.id).update(user_id: nil)
    Department.where(user_id: user.id).update(user_id: nil)

    UsersProject.delete(UsersProject.where(project_id: user.projects.ids, user_id: user.id).ids)
    UsersDepartment.delete(UsersDepartment.where(user_id: params[:id]).ids)

    Information.destroy(params[:id])
    User.destroy(params[:id])

  end

end
