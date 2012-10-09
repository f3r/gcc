class MigrateHomePageToCmspage < ActiveRecord::Migration
  def up
    Page.create({:page_title => "Home page - Footer", :page_url => 'home_page_footer', 
    :description => "<div class=\"tease-social\"><hr class=\"style-two\" />\r\n<div class=\"links\"><img src=\"https://s3.amazonaws.com/squarestays-static/icon.fb.jpg\" alt=\"\" width=\"30px\" height=\"30px\" /> <span class=\"social-text\"> <a href=\"https://www.facebook.com/squarestays\">Join us on Facebook</a> </span> <img src=\"https://s3.amazonaws.com/squarestays-static/icon.tw.jpg\" alt=\"\" width=\"30px\" height=\"30px\" /> <span class=\"social-text\"> <a href=\"https://twitter.com/#!/Squarestays\">Follow us on Twitter</a> </span> <img src=\"https://s3.amazonaws.com/squarestays-static/icon.rss.png\" alt=\"\" width=\"25px\" height=\"25px\" /> <span class=\"social-text\"> <a href=\"http://blog.squarestays.com\">Read our Blog</a> </span></div>\r\n<hr class=\"style-two\" /></div>\r\n<div class=\"tease-blurb\">\r\n<div class=\"tease-header\">Why should you use SquareStayz?</div>\r\n<div class=\"row\"><img src=\"http://s3.amazonaws.com/squarestays-static/flx.jpg\" alt=\"SquareStayz offers flexible, high-quality accommodations for you. SquareStayz is the destination site to find your perfect short-term or medium-term stay.\" /> <img src=\"http://s3.amazonaws.com/squarestays-static/qlty.jpg\" alt=\"SquareStayz works with professional Agents and Landlords to ensure a comfortable and professional experience you can trust.\" /> <img src=\"http://s3.amazonaws.com/squarestays-static/afrd.jpg\" alt=\"SquareStayz offers high quality and distinct properties - have your own home away from home for less then the price of a 5 star hotel.\" /></div>\r\n</div>\r\n<div class=\"trust\">\r\n<div class=\"row\"><img title=\"Small World Group\" src=\"http://s3.amazonaws.com/squarestays-static/swg.jpg\" alt=\"\" /> <img title=\"National Research Foundation\" src=\"http://s3.amazonaws.com/squarestays-static/nrf.jpg\" alt=\"\" /> <img title=\"PropNex\" src=\"http://s3.amazonaws.com/squarestays-static/prnx.jpg\" alt=\"\" /> <img title=\"Far East Organization\" src=\"http://s3.amazonaws.com/squarestays-static/feo.jpg\" alt=\"\" /></div>\r\n</div>", 
    :active => true, :mandatory => true})
  end

  def down
    page = Page.find_by_page_url('home_page_footer')
    page.destroy unless page.nil?
  end
end
