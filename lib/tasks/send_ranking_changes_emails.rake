namespace :rank_changes do
  desc "Sends ranking change notification"
  task :send_notification => :environment do
    require 'declarative_authorization/maintenance'
    Authorization::Maintenance.without_access_control do
      products = Product.where(:published => true).order("points DESC")
      count = 0
      products.each_with_index do |dj, rank|
        
        current_rank = rank + 1
        histroy = dj.dj_point_history
        last_rank = histroy.last.rank if histroy.present?
        
        if last_rank.present?
          if current_rank != last_rank 
            UserMailer.ranking_changes_notification(dj.user, current_rank, last_rank).deliver
            count += 1 
          end
        end
      end
      puts "No notifications sent !!!" if count == 0
      puts "#{count} notifications has been sent" if count > 0 
    end
  end
end
