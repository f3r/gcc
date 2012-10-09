require 'spec_helper'

describe MenuSection do
  before(:each) do
    setup_menus
  end

  it "check main not nil" do
    main = MenuSection.main
    main.should_not be_nil
  end

  it "check help not nil" do
    help = MenuSection.help
    help.should_not be_nil
  end

  it "check footer not nil" do
    footer = MenuSection.footer
    footer.should_not be_nil
  end

  it "no other menu section allowed with the same name" do
    menu_section = MenuSection.create(:name => "mAIn", :display_name => "MAIN")
    menu_section.should_not be_persisted
  end

  it "adds a page to menusection" do
    page = FactoryGirl.create(:cmspage)
    page.external?.should be_false

    main = MenuSection.main
    main.cmspages << page
    main.cmspages.count.should == 1
    page.menu_sections.count.should == 1
  end

  it "adds a link to menusection" do
    link = FactoryGirl.create(:external_link)
    link.should be_persisted
    link.external?.should be_true

    main = MenuSection.main
    main.cmspages << link
    main.cmspages.count.should == 1
  end

  it "invalid link should not be persisted" do
    link = ExternalLink.create({:page_title => Faker::Name.name, :page_url => "invalid url"})
    link.should_not be_persisted
  end

  it "delete a page should delete its entry from menusection" do
    main = MenuSection.main
    footer = MenuSection.footer

    # Let's create a page
    page1 = FactoryGirl.create(:cmspage)

    main.cmspages << page1
    footer.cmspages << page1

    #Another page
    page2 = FactoryGirl.create(:cmspage)
    main.cmspages << page2

    #Now the count is 2
    main.cmspages.count.should == 2
    footer.cmspages.count.should == 1

    page1.destroy
    main.cmspages.count.should == 1

    footer.cmspages.count.should == 0
  end
end

def setup_menus
  [
    ["main",          "main",       "Menu for users that are not signed in"],
    ["help",          "help",       "Menu for additional help topics"],
    ["footer",        "footer",     "Footer links"],
    ["menu_consumer", "User Menu",  "Menu for consumers users"],
    ["menu_agent",    "Agent Menu", "Menu for agent users"]
  ].each do |name, display_name, description|
    # next if MenuSection.exists?(name: name)
    MenuSection.create!({
      :name         => name,
      :display_name => display_name,
      :description  => description
    })
  end
end