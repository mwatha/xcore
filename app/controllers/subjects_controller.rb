class SubjectsController < ApplicationController
  def new
  end

  def show
    @subjects = Subjects.all
  end

  def select_subjects
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

    selecting_modules = (params[:selecting_modules] == 'true') rescue false

    render :text => live_search_results(programs,selecting_modules) and return
  end

  def details
    @module = Subjects.find params[:id]
  end

  def select_modules_to_enroll
    @program = Programs.find params[:program_id]                                        
    module_ids = ProgramsSubjectsRelationships.where(:'program_id' => @program. id).select(:subject_id)
    @modules = Subjects.where("id IN(?)",module_ids.map(&:subject_id))
  end

  protected

  def live_search_results(subjects,selecting_modules)                                             
      html=<<EOF                                                               
    <table id="search_results" class="table table-striped table-bordered table-condensed">                                                     
    <thead>                                                                       
      <tr id = 'table_head'>                                                        
        <th id="th1" style="width:200px;">Module ID</th>                           
        <th id="th2" style="width:200px;">Module name</th>                         
        <th id="th3" style="width:200px;">Date created</th>                         
        <th id="th7" style="width:100px;">&nbsp;</th>                               
      </tr> 
    </thead>
    <tbody>
EOF

                                                                            
    (subjects || []).each do |subject|                            
      unless selecting_modules              
        td = "<td><a href='/subjects/details?id=#{subject.try(:id)}'>Show</a></td>"
      else
        td = "<td><a href='#' onclick='addModule(#{subject.try(:id)})'>Select</a></td>"
      end
      html+=<<EOF                                                               
      <tr>                                                                        
        <td>#{subject.try(:id)}</td>                                            
        <td>#{subject.try(:name)}</td>                                          
        <td>#{subject.try(:created_at)}</td>                                    
        #{td}    
      </tr>
EOF
                                                                                
    end        
    
    if subjects.blank?
      html+=<<EOF                                                               
    <tr>                                                                        
      <td colspan='4' style="text-align:center;">Module(s) not found</td>                                                           
    </tr>                                                                       
EOF
                                                                                
    end
    return (html += "</tbody></table>")
  end

end
