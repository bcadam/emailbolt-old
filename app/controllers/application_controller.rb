class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :admin_user?
  helper_method :correct_user_nickname?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def correct_user_nickname?
      @user = User.find_by nickname: params[:nickname]
      if @user == nil
          count = User.where('LOWER(nickname) = ?', params[:nickname].downcase) unless params[:nickname].blank?
          @user = count.take
      end

      if !current_user || @user.id != current_user.id
        redirect_to root_url, :alert => 'That\'s not your page.'
      end

    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def admin_user?
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end

      if !current_user.has_role? :admin
        redirect_to root_url, :alert => 'You need to be an admin for access to this page.'
      end

    end

end
