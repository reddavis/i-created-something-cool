class Home < Application

  def index
    @new_projects = Project.find(:all, :limit => 10, :order => 'created_at DESC')
    @highest_rated = Project.find(:all).sort {|x,y| y.hearts.count <=> x.hearts.count}.first(10)
    render
  end
  
end
