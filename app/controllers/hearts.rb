class Hearts < Application
  before :login_required

  def create
    project = Project.find_by_stub(params[:project_stub])
    @heart = project.hearts.build(params[:heart])
    @heart.user_id = current_user.id
    @heart.save
    redirect resource(project)
  end
  
end