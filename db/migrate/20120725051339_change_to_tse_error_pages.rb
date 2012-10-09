class ChangeToTseErrorPages < ActiveRecord::Migration
  def up
    execute "UPDATE `cmspages` SET `description` = '<div class=\"error-page row\">\r\n<div class=\"span10 offset1\">\r\n<h2>We could not find the page you requested</h2>\r\n<div class=\"error-test\">We apologize for the inconvenience</div>\r\n<img class=\"error-image\" src=\"/assets/tse_404pic.png\" alt=\"404pic\" />\r\n</div>\r\n</div>' WHERE page_url='error_404'";
    execute "UPDATE `cmspages` SET `description` = '<div class=\"error-page row\">\r\n<div class=\"span10 offset1\">\r\n<h2>A Problem occured on this pages</h2>\r\n<p class=\"errro-subhead\">Our technicians have been notified of this error</p>\r\n<span class=\"error-text\">We apologize for the inconvenience</span>\r\n<img class=\"error-image\" src=\"/assets/tse_500pic.png\" alt=\"500pic\" />\r\n</div>\r\n</div>' WHERE page_url='error_500'";
  end

  def down
    execute "UPDATE `cmspages` SET `description` = '<div class=\"error-page row\">\r\n<div class=\"span10 offset1\">\r\n<h2>We could not find the page you requested</h2>\r\n<div class=\"error-test\">We apologize for the inconvenience</div>\r\n<img class=\"error-image\" src=\"/assets/404pic.png\" alt=\"404pic\" />\r\n</div>\r\n</div>' WHERE page_url='error_404'";
    execute "UPDATE `cmspages` SET `description` = '<div class=\"error-page row\">\r\n<div class=\"span10 offset1\">\r\n<h2>A Problem occured on this pages</h2>\r\n<p class=\"errro-subhead\">Our technicians have been notified of this error</p>\r\n<span class=\"error-text\">We apologize for the inconvenience</span>\r\n<img class=\"error-image\" src=\"/assets/500pic.png\" alt=\"500pic\" />\r\n</div>\r\n</div>' WHERE page_url='error_500'";
  end
end
