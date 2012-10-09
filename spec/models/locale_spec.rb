require 'spec_helper'

describe Locale do
  before(:each) do
    Locale.create(:code => "en", :name => 'English', :name_native => 'English', :active => true)
  end
  
  it "can be instantiated" do
    Locale.new.should be_an_instance_of(Locale)
  end

  it "finds currencies by symbol" do
    locale = Locale.where(:code => 'en')
    locale.should_not be_nil
  end
  
  it "check default locale status is false" do
    locale = Locale.create(:code => "es", :name => 'Spanish', :name_native => 'Spanish')
    locale.active.should == false
  end
  
  it "check locale status is true" do
    locale = Locale.create(:code => "es", :name => 'Spanish', :name_native => 'Spanish', :active => true)
    locale.active.should == true
  end
  
  it "finds locale,deactivate it and check status" do
    locale = Locale.create(:code => "es", :name => 'Spanish', :name_native => 'Spanish', :active => true)
    locale.deactivate!
    locale.active.should == false
  end
  
  it "finds locale, activate it and check status" do
    locale = Locale.create(:code => "es", :name => 'Spanish', :name_native => 'Spanish')
    locale.activate!
    locale.active.should == true
  end
  
end
