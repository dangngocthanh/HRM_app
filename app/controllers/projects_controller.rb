class ProjectsController < ApplicationController
  before_action :admin, only: [:create, :new]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(name: params['project']['name'] ,user_id:, department_id:)
    if @project.save
      redirect_to action: :index
    end
  end

  private

  def admin
    user = current_user
    p user
    if user.id = 1
    else
      redirect_to '/users/sign_in'
    end
  end

end
