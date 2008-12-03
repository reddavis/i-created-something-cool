class Projects < Application
  before :login_required, :exclude => [:index, :show]

  # GET /projects
  def index
    @projects = Project.paginate(:all, :page => params[:page], :per_page => 20)
    display @projects
  end

  # GET /projects/:id
  def show
    @project = Project.find_by_stub(params[:id])
    raise NotFound unless @project
    display @project
  end

  # GET /projects/new
  def new
    only_provides :html
    @project = Project.new(params[:project])
    render
  end

  # POST /projects
  def create
    @project = current_user.projects.build(params[:project])
    if @project.save
      redirect resource(@project)
    else
      render :new
    end
  end

  # GET /projects/:id/edit
  def edit
    only_provides :html
    @project = Project.find_by_stub(params[:id])
    raise NotFound unless @project
    render
  end

  # PUT /projects/:id
  def update
    @project = Project.find_by_stub(params[:id])
    raise NotFound unless @project
    if @project.update_attributes(params[:project])
      redirect url(:project, @project)
    else
      raise BadRequest
    end
  end

  # DELETE /projects/:id
  def destroy
    @project = Project.find_by_stub(params[:id])
    raise NotFound unless @project
    if @project.destroy
      redirect url(:projects)
    else
      raise BadRequest
    end
  end

end