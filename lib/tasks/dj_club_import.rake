namespace :dj_club do
  desc "Imports the club data from http://is.asia-city.com/nightlife/bars/browse"
  task :import => :environment do
    base_url = "http://is.asia-city.com"
    url =  "http://is.asia-city.com/nightlife/bars/browse"
    DjClub.destroy_all
    fd = open(url)
    doc = Nokogiri::HTML(fd)
    club_links = []
    doc.css(".item_container").each do |container|
        container.css(".list_items li a").each do |item|
          club_links << item[:href]
        end
    end
    fd.close
    count =  club_links.count
    puts "There are #{count} links to scrap!!!"

    i = 1

    club_links.each do |link|
      link = "#{base_url}#{link}"
      puts "#{i}/#{count}  -  #{link}"
      fd = open(link)
      club_page = Nokogiri::HTML(fd)
      location = club_page.css("meta[name=icbm]").attr("content").text
      name = club_page.css("div.title").first.text
      description = club_page.css("#dvPage > p").text
      details = club_page.css("#NeedToKnowDetails .detail")
      address = ""
      phone = ""
      website = ""
      email = ""
      image = club_page.css('meta[property="og:image"]').attr("content")
      details.each do |detail|
        d_t = ""
        detail.children.each do |item|
          if detail.children.count == 1
            if item.text != "Report a correction"
              address = item.text.strip
            end
          else
            d_t << item.text
          end
        end
        if d_t.include? "Phone:"
          phone = d_t.gsub!("Phone:", "").strip
        end

        if d_t.include? "Website:"
          website = d_t.gsub!("Website:", "").strip
        end

        if d_t.include? "Email:"
          email = d_t.gsub!("Email:", "").strip
        end
      end

      dj_club = DjClub.new
      dj_club.name = name.strip
      dj_club.email = email.strip
      dj_club.description = description.strip
      dj_club.location = location.strip
      dj_club.address = address.strip
      dj_club.photo1 = open(image.text.gsub(" ", "%20"))
      dj_club.phone = phone.strip
      dj_club.website = website.strip
      dj_club.save

      fd.close

      i = i + 1
    end

  end
end