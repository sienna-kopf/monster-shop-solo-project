class UsersController < ApplicationController

  before_action :require_user, only: [:show]

  def new

  end

  def create
    @new_user = User.new(user_params)
    if @new_user.valid?
      @new_user.save
      flash[:success] = "Hello, #{@new_user.name} You are now registered and logged in"
      session[:user_id] = @new_user.id
      redirect_to "/profile"
    else
      flash[:error] = @new_user.errors.full_messages.uniq.to_sentence
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    current_user.update(user_params)
    flash[:success] = "Information successfully updated."
    redirect_to "/profile"
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end

  def require_user
    render file: "/public/404" unless current_default?
  end
end
