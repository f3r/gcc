namespace :refresh do

  desc "Regenerate geolocation lat/long and recalculate currency conversion for all products"
  task :all => [:geolocation, :currency_conversion]

  desc "Regenerate geolocation lat/long for all products"
  task :geolocation => :environment do
    Product.all.each do |product|
      puts "Refreshing geolocation: [#{product.id}] #{product.title}"
      product.geocode
    end
  end

  desc "Regenerate currency for all products"
  task :currency_conversion => :environment do
    require 'declarative_authorization/maintenance'
    Authorization::Maintenance.without_access_control do
      Product.all.each do |product|
        puts "Refreshing: [#{product.id}] #{product.title}"
        product.convert_prices_to_usd
      end
    end
  end

  desc "Regenerate image versions"
  task :photos => :environment do
    Photo.all.each do |record|
      puts "Regenerating: [#{record.id}]"
      record.photo.reprocess!
    end
  end
end