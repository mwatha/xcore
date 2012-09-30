class SubjectsController < ApplicationController
  def new
  end

  def show
    @subjects = Subjects.all
  end

  def create
    Subjects.create(:name => params['subject']['name'], 
      :description => params['subject']['description'], 
      :creator => Users.current_user.id, :voided => 0)

    redirect_to :action => 'new'
  end

  def live_search
    programs = Subjects.where("(name LIKE '%#{params[:search_str]}%' 
      OR created_at LIKE '%#{params[:search_str]}%' 
      OR id LIKE '%#{params[:search_str]}%') AND voided = 0")
    render :text => live_search_results(programs) and return
  end

  protected

  def live_search_results(subjects)                                             
                                                                                
      html=<<EOF                                                               
    <table id="search_results" class="table table-striped table-bordered table-condensed">                                                     
    <thead>                                                                       
      <tr id = 'table_head'>                                                        
        <th id="th1" style="width:200px;">Subject ID</th>                           
        <th id="th2" style="width:200px;">Subject name</th>                         
        <th id="th3" style="width:200px;">Date created</th>                         
        <th id="th7" style="width:100px;">&nbsp;</th>                               
      </tr> 
    </thead>
    <tbody>
EOF

                                                                            
    (subjects || []).each do |subject|                                          
      html+=<<EOF                                                               
      <tr>                                                                        
        <td>#{subject.try(:id)}</td>                                            
        <td>#{subject.try(:name)}</td>                                          
        <td>#{subject.try(:created_at)}</td>                                    
        <td><a href="/programs/details?id=#{subject.try(:id)}">Show</a></td>    
      </tr>
EOF
                                                                                
    end        
    
    if subjects.blank?
      html+=<<EOF                                                               
    <tr>                                                                        
      <td colspan='4' style="text-align:center;">Subject(s) not found</td>                                                           
    </tr>                                                                       
EOF
                                                                                
    end
    return (html += "</tbody></table>")
  end

end
