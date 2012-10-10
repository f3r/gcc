namespace :dj_club do

  desc "Imports the club data from http://*.asia-city.com/nightlife/bars/browse"
  task :full_import => :environment do
    cities = [
        ["Hong Kong", "http://hk.asia-city.com"],
        ["Bangkok", "http://bk.asia-city.com"],
        ["Kaula Lumpur", "http://kl.asia-city.com"]
    ]


    cities.each do |city|
      city_name = city[0]
      city_base_url = city[1]

      city_model = City.find_or_create_by_name(city_name)

      import_clubs(city_model, city_base_url)

      city_model.active = true
      city_model.save
    end
  end

  #####
  #desc "Imports the club data from http://is.asia-city.com/nightlife/bars/browse"
  #task :import => :environment do
  #
  #end

  private
  def import_clubs(city, base_url)

    url = "#{base_url}/nightlife/bars/browse"

    puts "#### IMPORT FROM #{url} ######"

    #DjClub.destroy_all
    fd = open(url)
    doc = Nokogiri::HTML(fd)
    club_links = []
    doc.css(".item_container").each do |container|
      container.css(".list_items li a").each do |item|
        club_links << item[:href]
      end
    end
    fd.close
    count = club_links.count
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
      if club_page.css("#slide-img-1").present?
        image = club_page.css("#slide-img-1").attr('src')
      end
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
      dj_club.city = city
      dj_club.save

      fd.close

      i = i + 1

      # Only for dev - just import 10 clubs
      #break if i > 5
    end

    puts "DONE scraping #{url}"

  end
end