class People < ActiveRecord::Base
  set_primary_key "id"

  has_many :people_attributes, :class_name => "PeopleAttributes",
    :foreign_key => :people_id

  has_many :people_names, :class_name => "PeopleNames",
    :foreign_key => :people_id

    
end
