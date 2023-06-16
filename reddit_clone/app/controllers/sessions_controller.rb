class SessionsController < ApplicationController

    def new
        render :new 
    end 

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login(@user)
            redirect_to user_url(@user)
        else 
            @user = User.new(
            username: params[:user][:username],
            password: params[:user][:password])
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end 
    end 

    def destroy
        @current_user.log_out
        redirect_to new_session_url
    end 


end
