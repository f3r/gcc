namespace :password do
  desc "Sends the password reminders"
  task :send_reminders => :environment do
    # We take the users who hasn't yet logged in to our app and didn't check the password link in the last 1 week
    users = User.where(["sign_in_count = 0 and (reset_password_sent_at < ?)", Time.now - 1.week])
    count = 0
    users.each do |user|
      user.save_without_password
      UserMailer.auto_welcome(user, I18n.t('mailers.auto_welcome.content')).deliver
      puts "Reminder sent to #{user.email}"
      count += 1
    end

    puts "No reminders sent !!!" if count == 0
    puts "#{count} reminders has been sent" if count > 0

  end
end
