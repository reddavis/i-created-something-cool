require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/session" do
  before(:each) do
    @response = request("/session")
  end
end