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

  def live_search
    search_str_one = params[:search_str].split(' ')[0] || params[:search_str]
    search_str_two = params[:search_str].split(' ')[1] || params[:search_str]
    search_str_three = params[:search_str].split(' ')[2] || params[:search_str]

    search_str_one = "" if search_str_one.blank?
    search_str_two = "" if search_str_two.blank?
    search_str_three = "" if search_str_three.blank?

    students = People.joins(:people_names,
      :people_attributes).where("people_attributes.value = 'Student' 
      AND (first_name LIKE (?) OR last_name LIKE (?)
      OR last_name LIKE (?) OR first_name LIKE (?)
      OR middle_name LIKE (?) OR middle_name LIKE (?)
      OR birthdate LIKE (?) OR people.id LIKE (?)
      )
      ",
      "%#{search_str_one}%","%#{search_str_two}",
      "%#{search_str_one}%","%#{search_str_two}%",
      "%#{search_str_one}%","%#{search_str_three}%",
      "%#{search_str_one}%","%#{search_str_two}%"
      ).select("people.*,
      people_attributes.*,people_names.*").limit(20)

    render :text => live_search_results(students) and return
  end

  protected

  def live_search_results(students)                                             
                                                                                
      html=<<EOF                                                               
    <table id="search_results" class="table table-striped table-bordered table-condensed">                                                     
    <thead>                                                                       
      <tr id = 'table_head'>                                                        
        <th id="th1" style="width:200px;">Student ID</th>                           
        <th id="th2" style="width:200px;">First name</th>                           
        <th id="th3" style="width:200px;">Middle name</th>                          
        <th id="th3" style="width:200px;">Last name</th>                            
        <th id="th4" style="width:85px;">Sex</th>                                   
        <th id="th5" style="width:150px;">DOB</th>                                  
        <th id="th7" style="width:100px;">&nbsp;</th>                               
      </tr>                                                                         
    </thead>
    <tbody>
EOF

                                                                            
    (students || []).each do |student|                                          
      html+=<<EOF                                                               
    <tr>                                                                        
      <td>#{student.try(:id)}</td>                                              
      <td>#{student.try(:first_name)}</td>                                      
      <td>#{student.try(:middle_name)}</td>                                     
      <td>#{student.try(:last_name)}</td>                                       
      <td>#{student.try(:gender)}</td>                                          
      <td>#{student.try(:birthdate)}</td>                                       
      <td><a href="/students/show/#{student.try(:id)}">Show</a></td>                                                           
    </tr>                                                                       
EOF
                                                                                
    end        
    
    if students.blank?
      html+=<<EOF                                                               
    <tr>                                                                        
      <td colspan='7' style="text-align:center;">Student(s) not found</td>                                                           
    </tr>                                                                       
EOF
                                                                                
    end
    return (html += "</tbody></table>")
  end

end
