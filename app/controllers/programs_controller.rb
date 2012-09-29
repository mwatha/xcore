class ProgramsController < ApplicationController
  def show
    @programs = Programs.where(:'voided' => 0)
  end

  def live_search
    programs = Programs.where("(name LIKE '%#{params[:search_str]}%' 
      OR created_at LIKE '%#{params[:search_str]}%' 
      OR id LIKE '%#{params[:search_str]}%') AND voided = 0")
    render :text => live_search_results(programs) and return
  end

  def create
    Programs.create(:name => params['program']['name'], 
      :description => params['program']['description'], 
      :creator => Users.current_user.id, :voided => 0)

    redirect_to :action => 'new'
  end

  protected

  def live_search_results(programs)                                             
                                                                                
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
      html+=<<EOF                                                               
      <tr>                                                                        
        <td>#{program.try(:id)}</td>                                            
        <td>#{program.try(:name)}</td>                                          
        <td>#{program.try(:created_at)}</td>                                    
        <td><a href="/programs/details?id=#{program.try(:id)}">Show</a></td>    
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
