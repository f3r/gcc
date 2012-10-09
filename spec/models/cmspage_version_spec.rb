require 'spec_helper'

describe CmspageVersion do
  
  before(:each) do
    @page = build(:cmspage)
    @page.description = "CONTENT1"
    @page.save
  end
  
  it "check no versions in initial" do
    @page.cmspage_versions.count.should == 0
  end
  
  it "creates one version" do
    @page.description = "CONTENT2"
    @page.save
    @page.cmspage_versions.count.should == 1
  end

  it "checks the version saved" do
    @page.description = "CONTENT2"
    @page.save
    @page.cmspage_versions.first.content.should == 'CONTENT1'
  end
end