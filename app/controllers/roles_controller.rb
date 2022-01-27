class RolesController < ApplicationController
  before_action :admin, only: [:new, :edit, :create, :update, :destroy]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(name: params['role']['name'])
    if @role.save
      redirect_to action: :index
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(name: params['role']['name'])
      redirect_to action: :index
    end
  end

  def destroy
    if Role.delete(params[:id])
      redirect_to action: :index
    end
  end

  private

  def admin
    user = current_user
    p user
    if user.id == 1
    else
      redirect_to '/users/sign_in'
    end
  end
end


