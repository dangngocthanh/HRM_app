class UsersProjectsController < ApplicationController
  layout "dashboard"
  def index
    p session[:id]
    @users = UsersProject.where(project_id: session[:id])
  end

end
