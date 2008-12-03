class Application < Merb::Controller
  before :fetch_current_user
  
  def current_user
    @current_user
  end
  
  def login_required
    return true if !current_user.blank?
    session[:return_to] = request.env['REQUEST_URI']
    throw :halt, redirect(url(:controller => :session, :action => :new), :message => 'You need to be signed in to do that')
  end
  
  protected
  
  def fetch_current_user
    return if session[:user_id].blank?
    @current_user = User.find(session[:user_id])
  end
  
end