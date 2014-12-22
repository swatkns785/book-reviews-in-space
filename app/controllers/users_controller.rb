class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Your account has been succesfully created."
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password
    )
  end

end
