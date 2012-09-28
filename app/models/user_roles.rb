class UserRoles < ActiveRecord::Base
  belongs_to :user, :class_name => "Users", :foreign_key => :id

end
