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

end
