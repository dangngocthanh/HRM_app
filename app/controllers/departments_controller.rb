class DepartmentsController < ApplicationController
  before_action :IsAdmin?, only: [:new, :create]

  def index
    if current_user.information.role_id == 1 || current_user.information.role_id == 2
      @departments = Department.all
    else
      @departments = UsersDepartment.where(user_id: current_user.id)
      if @departments[0] != nil
        @department = Department.find(@departments[0].department_id)
      end
    end
  end

  # def show
  #   @department = Department.find(params[:id])
  # end

  def new
    @users = Information.where('role_id != 2').where(has_department: false)
    @department = Department.new
  end

  def create
    user_id = params['department']['user_id']
    @department = Department.new(name: params['department']['name'], user_id: user_id)
    if @department.save
      if add_user_department(user_id)
        if update_role_PM(user_id)
          redirect_to action: :index
        end
      end
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(name: params['department']['name'])
      redirect_to action: :index
    end
  end

  def destroy
    if Department.delete(params[:id])
      redirect_to action: :index
    end
  end

  private

  def add_user_department (user_id)
    id = Department.last
    id = id.id
    @users_department = UsersDepartment.new(department_id: id, user_id: user_id)
    @users_department.save
  end

  def update_role_PM (user_id)
    @user = Information.find(user_id)
    @user.update(role_id: 3)
    @user.update(has_department: true)
    # @user.save
  end

end
