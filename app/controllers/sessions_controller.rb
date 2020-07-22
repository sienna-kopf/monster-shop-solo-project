class SessionsController < ApplicationController
  before_action :require_user

  def new
  end

  def create
    session[:user_id] = current_user.id
    flash[:success] = "You are now successfully logged in as #{current_user.name}"
    if current_admin?
      redirect_to '/admin/dashboard'
    elsif current_merchant?
      redirect_to "/merchant/dashboard"
    else
      redirect_to "/profile"
    end
  end

  private

  def require_user
    render file: "/public/404" unless current_default?
  end
end
