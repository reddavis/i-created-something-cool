require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a projectse exists" do
  Projectse.delete_all
  request(resource(:projectses), :method => "POST", 
    :params => { :projectse => { :id => nil }})
end

describe "resource(:projectses)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:projectses))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of projectses" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a projectse exists" do
    before(:each) do
      @response = request(resource(:projectses))
    end
    
    it "has a list of projectses" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Projectse.delete_all
          @response = request(resource(:projectses), :method => "POST", 
        :params => { :projectse => { :id => nil }})
    end
    
    it "redirects to resource(:projectses)" do
      @response.should redirect_to(resource(Projectse.first), :message => {:notice => "projectse was successfully created"})
          end
    
  end
end

describe "resource(@projectse)" do 
  describe "a successful DELETE", :given => "a projectse exists" do
     before(:each) do
       @response = request(resource(Projectse.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:projectses))
     end

   end
end

describe "resource(:projectses, :new)" do
  before(:each) do
    @response = request(resource(:projectses, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@projectse, :edit)", :given => "a projectse exists" do
  before(:each) do
    @response = request(resource(Projectse.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@projectse)", :given => "a projectse exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Projectse.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @projectse = Projectse.first
      @response = request(resource(@projectse), :method => "PUT", 
        :params => { :projectse => {:id => @projectse.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@projectse))
    end
  end
  
end

