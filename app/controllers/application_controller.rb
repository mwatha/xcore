class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :perform_basic_auth, :except => :login

  protected

  def perform_basic_auth
    if session[:user_id].blank?
      respond_to do |format|                                                      
        format.html { redirect_to :controller => 'users',:action => 'login' }    
      end
    elsif not session[:user_id].blank?
      Users.current_user = Users.where(:'id' => session[:user_id]).first
    end
  end

end
