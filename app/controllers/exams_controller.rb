class ExamsController < ApplicationController
  def dashboard
  end

  def schedule_an_exam
    @programs = Programs.where(:'voided' => 0)
  end

  def live_search
    programs = Programs.where("(name LIKE '%#{params[:search_str]}%' 
      OR created_at LIKE '%#{params[:search_str]}%' 
      OR id LIKE '%#{params[:search_str]}%') AND voided = 0")

    selecting_program = (params[:selecting_program] == 'true') rescue false
    if not (params[:student_id].blank?) 
      selecting_program = params[:student_id]
    end

    render :text => live_search_results(programs,selecting_program) and return
  end

  def create
    Programs.create(:name => params['program']['name'], 
      :description => params['program']['description'], 
      :creator => Users.current_user.id, :voided => 0)

    redirect_to :action => 'new'
  end

  def confirm_modules
    module_ids = params[:module_ids].split(',').uniq 

    @program = Programs.find params[:program_id]
    @modules = Subjects.where("id IN(?)",module_ids)
  end

  def create_exam_schedule
    schedules =  JSON.parse(params[:module_ids])

    (schedules || {}).each do |subject_id,values|
      start_date = "#{values[0].to_date} #{values[2]}:00".to_time
      end_date = start_date + (values[1].to_i).hour
      ExamSchedules.create(:program_id => params[:program_id], 
        :subject_id => subject_id,:start_date => start_date,
        :end_date => end_date,:creator => Users.current_user.id, :voided => 0)
    end

    redirect_to :action => 'dashboard'
  end

  def select_modules
    @program = Programs.find params[:id]
    module_ids = ProgramsSubjectsRelationships.where(:'program_id' => @program.id).select(:subject_id)
    @modules = Subjects.where("id IN(?)",module_ids.map(&:subject_id))
  end

  def schedule
    @schedules = ExamSchedules.joins("INNER JOIN programs p 
      ON p.id = exam_schedules.program_id INNER JOIN subjects s 
      ON s.id=exam_schedules.subject_id").select("exam_schedules.id schedule_id,
      p.name program_name,s.name module_name,start_date,end_date")
  end

  protected

  def live_search_results(programs,selecting_program)                   
      html=<<EOF                                                               
    <table id="search_results" class="table table-striped table-bordered table-condensed">                                                     
    <thead>                                                                       
      <tr id = 'table_head'>                                                        
        <th id="th1" style="width:200px;">Program ID</th>                           
        <th id="th2" style="width:200px;">Program name</th>                         
        <th id="th3" style="width:200px;">Date created</th>                         
        <th id="th7" style="width:100px;">&nbsp;</th>                               
      </tr> 
    </thead>
    <tbody>
EOF

                                                                            
    (programs || []).each do |program|                                          
      if ((selecting_program).to_s.to_i > 0)
        url = "/subjects/select_modules_to_enroll?student_id=#{selecting_program}&program_id=#{program.id}"
        caption = 'Select'                          
      elsif selecting_program.to_s == 'false'                      
        caption = 'Show' 
        url = "/programs/details?id=#{program.try(:id)}"
      elsif selecting_program.to_s == 'true'
        url = "/exams/select_modules?id=#{program.try(:id)}"
        caption = 'Select' if selecting_program                          
      end
                                                                                
      html+=<<EOF                                                               
      <tr>                                                                        
        <td>#{program.try(:id)}</td>                                            
        <td>#{program.try(:name)}</td>                                          
        <td>#{program.try(:created_at)}</td>                                    
        <td><a href="#{url}">#{caption}</a></td>    
      </tr>
EOF
                                                                                
    end        
    
    if programs.blank?
      html+=<<EOF                                                               
    <tr>                                                                        
      <td colspan='4' style="text-align:center;">Program(s) not found</td>                                                           
    </tr>                                                                       
EOF
                                                                                
    end
    return (html += "</tbody></table>")
  end
end
