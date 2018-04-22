class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
	      #redirect_to @user, notice: "Thanks for signing up!"
        flash[:success] = "Thanks for signing up!"
        redirect_to @user
	    else
	      render :new
	    end 
	  end

  def update
    if @user.update(user_params)
	      #redirect_to @user, notice: "Account successfully updated!"
	       flash[:success] = "Account successfully updated!"
         redirect_to @user
      else
	      render :edit
	  end
  end

  def destroy
    @user.destroy
	    #redirect_to users_path, alert: "Account successfully deleted!"
      flash[:danger] = "Account successfully deleted!"
      redirect_to users_path
  end

private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end