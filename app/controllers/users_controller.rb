class UsersController < ApplicationController
  def login
    if request.post?
      user = Users.find_by_username params[:user]["username"]                                      
      if user and user.password_matches?(params[:user]["password"])                       
        session[:user_id] = user.id
        redirect_to "/"
      else                                                                        
        flash[:error] = 'That username and/or password was not valid.'            
      end   
    else
      reset_session
    end
  end

end
