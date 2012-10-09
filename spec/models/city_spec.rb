require 'spec_helper'

describe City do
  before(:each) do
    City.create(:name => "Singapore", :lat => 1.28967, :lon => 103.85, :country => "Singapore", :country_code => "SG", :active => true, :slug => "singapore")
  end

  it "can be instantiated" do
    City.new.should be_an_instance_of(City)
  end
  
  it "finds cities by name" do
    city = City.find('singapore')
    city.should_not be_nil
    city.code.should == :singapore
  end

  it "provides matcher for routes" do
    City.routes_regexp.should == /singapore/
    City.create(:name => "Buenos Aires", :country => "Argentina", :country_code => "AR", :active => true)
    City.routes_regexp.should == /singapore|buenos-aires/
  end
  
  it "check default city status is false" do
    city = City.create(:name => "Singapore", :lat => 1.28967, :lon => 103.85, :country => "Singapore", :country_code => "SG",:slug => "singapore")
    city.active.should == false
  end
  
  it "check city status is true" do
    city = City.create(:name => "Singapore", :lat => 1.28967, :lon => 103.85, :country => "Singapore", :country_code => "SG",:slug => "singapore",:active => true)
    city.active.should == true
  end

  it "finds city,deactivate it and check status" do
    city = City.create(:name => "Singapore", :lat => 1.28967, :lon => 103.85, :country => "Singapore", :country_code => "SG",:slug => "singapore",:active => true)
    city.deactivate!
    city.active.should == false
  end
  
  it "finds city, activate it and check status" do
    city = City.create(:name => "Singapore", :lat => 1.28967, :lon => 103.85, :country => "Singapore", :country_code => "SG",:slug => "singapore")
    city.activate!
    city.active.should == true
  end
  
end
