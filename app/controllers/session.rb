class Session < Application

  def new
    render
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect '/'
    else
      @_message = "You supplied a wrong username or password"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect '/'
  end
  
end
