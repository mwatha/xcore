class Users < ActiveRecord::Base
  cattr_accessor :current_user                                                  
                                                                                
  belongs_to :people

  before_save do |pass|
    self.password_hash = BCrypt::Password.create(self.password_hash)
  end

  def password_matches?(plain_password)                                         
    not plain_password.nil? and self.password == plain_password                 
  end 

  def password                                                                  
    @password ||= BCrypt::Password.new(password_hash)                           
  rescue BCrypt::Errors::InvalidHash                                            
    Rails.logger.error "The password_hash attribute of User[#{self.username}] does not contain a valid BCrypt Hash."
    return nil                                                                  
  end

  def password=(new_password)                                                   
    @password = BCrypt::Password.create(new_password)                           
    self.password_hash = @password                                              
  end

end
