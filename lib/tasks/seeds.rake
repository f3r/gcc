namespace :seeds do
  desc "Load initial data for silvertroopers"
  task :service => :environment do
    require Rails.root.to_s + '/db/services/seeds.rb'
  end

  task :property => :environment do
    require Rails.root.to_s + '/db/properties/seeds.rb'
  end
end