require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a heart exists" do
  Heart.delete_all
  request(resource(:hearts), :method => "POST", 
    :params => { :heart => { :id => nil }})
end

describe "resource(:hearts)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:hearts))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of hearts" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a heart exists" do
    before(:each) do
      @response = request(resource(:hearts))
    end
    
    it "has a list of hearts" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Heart.delete_all
          @response = request(resource(:hearts), :method => "POST", 
        :params => { :heart => { :id => nil }})
    end
    
    it "redirects to resource(:hearts)" do
      @response.should redirect_to(resource(Heart.first), :message => {:notice => "heart was successfully created"})
          end
    
  end
end

describe "resource(@heart)" do 
  describe "a successful DELETE", :given => "a heart exists" do
     before(:each) do
       @response = request(resource(Heart.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:hearts))
     end

   end
end

describe "resource(:hearts, :new)" do
  before(:each) do
    @response = request(resource(:hearts, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@heart, :edit)", :given => "a heart exists" do
  before(:each) do
    @response = request(resource(Heart.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@heart)", :given => "a heart exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Heart.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @heart = Heart.first
      @response = request(resource(@heart), :method => "PUT", 
        :params => { :heart => {:id => @heart.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@heart))
    end
  end
  
end

