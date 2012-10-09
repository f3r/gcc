class MigrateExistingMenuSections < ActiveRecord::Migration
  def up
    MenuSection.reset_column_information
    MenuSection.destroy_all
    # Create all the defaults
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

    #Creating the main menu
    main = MenuSection.main
    p = Cmspage.find_by_url 'how-it-works'
    main.cmspages << p
    p = Cmspage.find_by_url 'why'
    main.cmspages << p
    #########

    #Creating the help menu
    help = MenuSection.help
    p = Cmspage.find_by_url 'how-it-works'
    help.cmspages << p
    p = Cmspage.find_by_url 'why'
    help.cmspages << p
    p = Cmspage.find_by_url 'singapore-city-guide'
    help.cmspages << p
    p = Cmspage.find_by_url 'hong-kong-city-guide'
    help.cmspages << p
    p = Cmspage.find_by_url 'kuala-lumpur-city-guide'
    help.cmspages << p

    #Add the external link to getsatisfaction
    l1 = ExternalLink.create({:page_title => "Community Support", :page_url => "https://getsatisfaction.com/squarestays", :active => true})
    help.cmspages << l1
    ########

    #Creating the footer menu
    footer = MenuSection.footer
    p = Cmspage.find_by_url 'terms'
    footer.cmspages << p
    p = Cmspage.find_by_url 'privacy'
    footer.cmspages << p
    p = Cmspage.find_by_url 'contact'
    footer.cmspages << p
    #####

  end

  def down
    l1 = ExternalLink.find_by_url 'https://getsatisfaction.com/squarestays'
    l1.destroy
    say "Deleted external link: #{l1}"
  end
end
