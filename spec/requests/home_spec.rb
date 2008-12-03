require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/home" do
  before(:each) do
    @response = request("/home")
  end
end