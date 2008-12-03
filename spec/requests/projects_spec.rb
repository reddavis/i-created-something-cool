require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a project exists" do
  Project.delete_all
  request(resource(:projects), :method => "POST", 
    :params => { :project => { :id => nil }})
end

describe "resource(:projects)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:projects))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of projects" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a project exists" do
    before(:each) do
      @response = request(resource(:projects))
    end
    
    it "has a list of projects" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Project.delete_all
          @response = request(resource(:projects), :method => "POST", 
        :params => { :project => { :id => nil }})
    end
    
    it "redirects to resource(:projects)" do
      @response.should redirect_to(resource(Project.first), :message => {:notice => "project was successfully created"})
          end
    
  end
end

describe "resource(@project)" do 
  describe "a successful DELETE", :given => "a project exists" do
     before(:each) do
       @response = request(resource(Project.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:projects))
     end

   end
end

describe "resource(:projects, :new)" do
  before(:each) do
    @response = request(resource(:projects, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@project, :edit)", :given => "a project exists" do
  before(:each) do
    @response = request(resource(Project.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@project)", :given => "a project exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Project.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @project = Project.first
      @response = request(resource(@project), :method => "PUT", 
        :params => { :project => {:id => @project.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@project))
    end
  end
  
end

