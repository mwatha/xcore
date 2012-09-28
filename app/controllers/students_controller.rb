class StudentsController < ApplicationController
  
  def view
  end
  
  def new
  end

  def create
    type = PeopleAttributeTypes.where(:'name' => 'Student')[0]

    people = People.create(:birthdate => params['student']['dob'].to_date, 
      :gender => params['student']['gender'], :creator => Users.current_user.id, :voided => 0)

    PeopleNames.create(:people_id => people.id , :first_name => params['student']['first_name'], 
      :last_name => params['student']['last_name'],:middle_name => params['student']['middle_name'],
       :creator => Users.current_user.id, :voided => 0)                                                   

    PeopleAttributes.create(:people_id => people.id,:value => 'Student', 
      :people_attribute_type_id => type.id, :creator => Users.current_user.id, :voided => 0)


    redirect_to :action => 'new'
  end

  def search
    @students = People.joins(:people_names,
      :people_attributes).where(:'people_attributes.value' => 'Student').select("people.*,
        people_attributes.*,people_names.*").limit(20)
  end

end
