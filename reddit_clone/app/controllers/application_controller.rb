class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def current_user 
        @current_user = User.find_by(session_token: session[:session_token])
    end 

    def login(user)
        @current_user = user 
        session[:session_token] = @current_user.reset_session_token
    end 

    def log_out
        session[:session_token] = nil 
        current_user.reset_session_token
    end 

    def logged_in?
        !!current_user
    end 

    def require_logged_in 
        redirect_to new_session_url unless logged_in?
    end 

    def require_logged_out 
        redirect_to new_session_url if logged_in?
    end 

end
