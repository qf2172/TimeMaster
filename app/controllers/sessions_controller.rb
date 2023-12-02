class SessionsController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        # Log the user in
        log_in user
        redirect_to tasks_path
      else
        # Create an error message and re-render the signin form
        flash.now[:login_error] = "Invalid email or password."
        render 'new'
      end

    end
  
    def destroy
      log_out if logged_in?
      redirect_to root_url
    end
  
    private
  
    # Log in the given user
    def log_in(user)
      session[:user_id] = user.id
    end
  
    # Returns true if the user is logged in, false otherwise
    def logged_in?
      !session[:user_id].nil?
    end
  
    # Logs out the current user
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
  end