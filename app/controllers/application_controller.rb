class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  private
  def user_not_authorized
    flash[:error] = t "notification.not_admin"
    redirect_to request.referrer || new_user_session_path
  end

  protected
  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, information_attributes: [:name, :address, :date_of_birth, :phone, :role_id]]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def IsAdmin?
    if current_user.information.role_id == 1
    else
      redirect_to '/'
    end
  end

  def RoleToUser users
    @users = []
    users.each do |user|
      user = User.where(id: user.user_id)
      @users.push(user[0])
    end
    return @users
  end
end
