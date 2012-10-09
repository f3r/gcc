class MigrateErrorPagesToCmspage < ActiveRecord::Migration
  def up
    Page.create({:page_title => "Error - 404", :page_url => 'error_404', 
    :description => "<div class=\"error-page row\">\r\n<div class=\"span10 offset1\">\r\n<h2>We could not find the page you requested</h2>\r\n<div class=\"error-test\">We apologize for the inconvenience</div>\r\n<img class=\"error-image\" src=\"/assets/404pic.png\" alt=\"404pic\" /></div>\r\n</div>", 
    :active => true, :mandatory => true})
    
    Page.create({:page_title => "Error - 500", :page_url => 'error_500', 
    :description => "<div class=\"error-page row\">\r\n<div class=\"span10 offset1\">\r\n<h2>A Problem occured on this page</h2>\r\n<p class=\"errro-subhead\">Our technicians have been notified of this error</p>\r\n<span class=\"error-text\">We apologize for the inconvenience</span> <img class=\"error-image\" src=\"/assets/500pic.png\" alt=\"500pic\" /></div>\r\n</div>", 
    :active => true, :mandatory => true})
        
  end

  def down
    page = Page.find_by_page_url('error_404')
    page.destroy unless page.nil?

    page = Page.find_by_page_url('error_500')
    page.destroy unless page.nil?

  end
end
