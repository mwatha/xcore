class HomeController < ApplicationController
  def index
    @total_registered_students = People.joins(:people_names,                                     
      :people_attributes).where(:'people_attributes.value' => 'Student').select("people.*,
        people_attributes.*,people_names.*").count
    @total_available_programs = Programs.count
    @total_available_staff =  People.joins(:people_names,                    
      :people_attributes).where(:'people_attributes.value' => 'Staff').select("people.*,
        people_attributes.*,people_names.*").count 
  end

end
