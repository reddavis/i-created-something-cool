class Users < Application
  # provides :xml, :yaml, :js

  # GET /users
  def index
    @users = User.find(:all)
    display @users
  end

  # GET /users/:id
  def show
    @user = User.find_by_id(params[:id])
    raise NotFound unless @user
    display @user
  end

  # GET /users/new
  def new
    only_provides :html
    @user = User.new(params[:user])
    render
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect '/'
    else
      render :new
    end
  end

end