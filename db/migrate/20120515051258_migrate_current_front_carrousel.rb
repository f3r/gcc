class MigrateCurrentFrontCarrousel < ActiveRecord::Migration
  def up
    #Create Gallery
    home_gallery = Gallery.create(:name => "homepage")
    
    gi = home_gallery.gallery_items.new({link: "http://www.squarestays.com/singapore/5-the-clift-prime-location-loft-with-view", label: I18n.translate("pages.front_page.carousel.one"), position: 1, active: 1})
    gi.photo = File.open("#{Rails.root}/db/migrate/existingcarrouselimages/one.jpg")
    gi.save!
    
    gi = home_gallery.gallery_items.new({link: "http://www.squarestays.com/singapore/2-cavenagh-lodge-central-great-for-family", label: I18n.translate("pages.front_page.carousel.two"), position: 2, active: 1})
    gi.photo = File.open("#{Rails.root}/db/migrate/existingcarrouselimages/two.jpg")
    gi.save!

    gi = home_gallery.gallery_items.new({link: "http://www.squarestays.com/kuala_lumpur", label: I18n.translate("pages.front_page.carousel.three"), position: 3, active: 1})
    gi.photo = File.open("#{Rails.root}/db/migrate/existingcarrouselimages/three.jpg")
    gi.save!
    
    gi = home_gallery.gallery_items.new({link: "/city-guides/singapore", label: I18n.translate("pages.front_page.carousel.four"), position: 4, active: 1})
    gi.photo = File.open("#{Rails.root}/db/migrate/existingcarrouselimages/four.jpg")
    gi.save!

    gi = home_gallery.gallery_items.new({link: "/city-guides/hong-kong", label: I18n.translate("pages.front_page.carousel.five"), position: 5, active: 1})
    gi.photo = File.open("#{Rails.root}/db/migrate/existingcarrouselimages/five.jpg")
    gi.save!
        
  end

  def down
  end
end
