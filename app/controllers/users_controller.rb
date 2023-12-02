class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      puts user_params
      @user = User.new(user_params)
      if @user.save
        # Redirect to task page
        redirect_to login_path, notice: 'Successfully signed up! Please log in.'
      else
        render :new  
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end