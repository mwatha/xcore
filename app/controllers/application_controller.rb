class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :perform_basic_auth, :only => :login

  protected

  def perform_basic_auth
    if not (session[:user_id].blank?)
      respond_to do |format|                                                      
        format.html { redirect_to :controller => 'users',:action => 'login' }    
      end
    end
  end

end
