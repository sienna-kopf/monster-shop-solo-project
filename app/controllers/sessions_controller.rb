class SessionsController < ApplicationController
  # before_action :check_signed_in

  def new
  end

  def create
    if current_user
      if current_user.authenticate(params[:password]) && current_user.email == params[:email]
        session[:user_id] = current_user.id
        flash[:success] = "You are now successfully logged in as #{current_user.name}"
        if current_admin?
          redirect_to '/admin/dashboard'
        elsif current_merchant?
          redirect_to "/merchant/dashboard"
        else
          redirect_to "/profile"
        end
      else
        flash[:error] = "Bad Credentials. Try Again!"
        render :new
      end
    else
      flash[:error] = "You must have an account to log in!"
      render :new
    end
  end

  # private

  # def check_signed_in
  #   if current_user
  #     redirect_to "/profile"
  #     flash[:error] = "Already Logged In."
  #   elsif current_merchant?
  #     redirect_to "/merchant/dashboard"
  #     flash[:error] = "Already Logged In."
  #   elsif current_admin?
  #     redirect_to "/admin/dashboard"
  #     flash[:error] = "Already Logged In."
  #   else
  #     redirect_to root_path
  #   end
  # end
end
