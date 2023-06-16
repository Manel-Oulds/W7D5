class UsersController < ApplicationController
    before_action :require_logged_in, only: [:show, :index]
    before_action :require_logged_out, only: [:create, :new]

    def index 
        @users = User.all 
    end 

    def new
        @user = User.new 
    end 

    def create 
        @user = User.new(params_users)
        if @user.save 
            login(@user)
            redirect_to user_url(@user)
        else 
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end 

    def show 
        @user = User.find(params[:id])
        render :show
    end 


    private 

    def params_users
        params.require(:user).permit(:username, :password)
    end 


end
