class Adddefaultmetacontent < ActiveRecord::Migration
  def up
     execute "UPDATE `site_configs` SET `custom_meta`='<meta name=\"robots\" content=\"noodp\" />\r\n<meta name=\"slurp\" content=\"noydir\" />'";
     execute "UPDATE `site_configs` SET `meta_description`='Apartment Rentals'";
     execute "UPDATE `site_configs` SET `meta_keywords`='heypal '";
  end

  def down
  end
end