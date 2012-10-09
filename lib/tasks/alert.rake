namespace :alerts do
  desc "Sends out the alert mails"
  task :send_alert => :environment do
    puts "Start sending ..."
    Alert.send_alerts
    puts "Sent"
  end

  desc "Prepare scheduled payment"
  task :prepare_payments => :environment do
    Payment.prepare_payments
  end
end