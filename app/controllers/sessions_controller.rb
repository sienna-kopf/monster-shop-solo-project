class SessionsController < ApplicationController

  def new
    if current_admin?
      redirect_to "/admin/dashboard"
      flash[:error] = "Already Logged In."
    elsif current_merchant?
      redirect_to "/merchant/dashboard"
      flash[:error] = "Already Logged In."
    elsif current_user
      redirect_to "/profile"
      flash[:error] = "Already Logged In."
    else
      return
    end
  end

  def create
    if user = User.find_by_email(params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "You are now successfully logged in as #{user.name}"
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
end
