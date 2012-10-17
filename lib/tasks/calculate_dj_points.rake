require "#{Rails.root}/app/helpers/application_helper"
require "#{Rails.root}/app/helpers/products_helper"
include ApplicationHelper
include ProductsHelper

namespace :calculate_dj_points do

  desc "Calculate DJ Points"
  task :assign_points => :environment do
    require 'declarative_authorization/maintenance'
    Authorization::Maintenance.without_access_control do
      
      products = Product.where(:published => true).order("points DESC")
      products.each_with_index do |dj, rank|
        points = 0;
        dj_point = 1;
        
        fb_cf_url = facebook_url_custom_field(dj)
        count = fb_likes_count(fb_cf_url) if fb_cf_url.present?
        points = count * dj_point if count.present?
        current_point = dj.points
        dj.points = points
        dj.save
        
        dj_point_history = dj.dj_point_history.new
        dj_point_history.points = current_point
        dj_point_history.rank = rank + 1 
        dj_point_history.date = Time.now
        dj_point_history.save
      end
    end
  end
  
end