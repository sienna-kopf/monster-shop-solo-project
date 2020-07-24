class PasswordsController < ApplicationController
  def edit
  end

  def update
    user = User.find_by_email(current_user.email)
    if user.authenticate(params[:current_password])
      if params[:new_password] == params[:new_password_confirmation]
        user.update(password: params[:new_password])
        if user.save
          flash[:success] = "Password successfully updated."
          redirect_to "/profile"
        else
          flash[:error] = user.errors.full_messages.uniq.to_sentence
          redirect_to "/users/password/edit"
        end
      else
        flash[:error] = "New password does not match."
        redirect_to "/users/password/edit"
      end
    else
      flash[:edit] = "Current Password does not match."
      redirect_to "/users/password/edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:new_password)
  end
end
