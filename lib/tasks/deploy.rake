namespace :deploy do
  DB_PATH   = "mysql2://heypaladmin:HYpl99db@heypal-useast-1.c7xsjolvk9oh.us-east-1.rds.amazonaws.com/"
  EMAILS    = "fer@heypal.com,nico@heypal.com"
  S3_ACCESS_KEY_ID     = 'AKIAJOJEIAZ6LOVHDFDA'
  S3_SECRET_ACCESS_KEY = '+IAdwXN9Ea8cA/TE8/1VNn+DoMf+hg/h8B8YDV0Z'

  def app
    ENV['APP'] || raise("Please specify app name with APP=<name of your app>")
  end

  def app_setup
    "--app #{app}"
  end

  def app_confirm
    "#{app_setup} --confirm #{app}"
  end


  task :full => [:push_config, :push, :migrate, :load_translations, :restart]

  task :quick => [:push]

  task :create_remote do
    header 'Creating new git remote locally'
    cmd "git remote add #{app} git@heroku.com:#{app}.git"
  end

  task :push do
    header 'Deploying site to Heroku ...'
    if %x[git status|grep "working directory clean"|wc -l].to_i == 1
      cmd "git push #{app} HEAD:master --force"
    else
      puts "Please commit all your changes before pushing!"
    end
  end

  task :push_config do
    header 'Pushing configuration ...'
    cmd "rake #{app} heroku:config"
  end

  task :restart do
    header 'Restarting app servers ...'
    cmd "heroku restart #{app_setup}"
  end

  task :migrate do
    header 'Running database migrations ...'
    cmd "heroku run rake db:migrate #{app_setup}"
  end

  task :load_translations do
    #header 'Loading new translations ...'
    #cmd "heroku run rake i18n:populate:from_rails #{app_setup}"
  end

  task :off do
    header 'Putting the app into maintenance mode ...'
    cmd "heroku maintenance:on #{app_setup}"
  end

  task :on do
    header 'Taking the app out of maintenance mode ...'
    cmd "heroku maintenance:off #{app_setup}"
  end

  task :new_site => [:new_app_heroku, :addons, :addons_open_browser, :new_s3_bucket, :push_config, :create_remote, :push, :new_database_setup, :load_translations, :load_seeds]

  task :new_app_heroku do
    header 'Creating new site infrastructure'
    header_subsection 'Creating app in heroku'
    cmd "heroku apps:create #{app}"
    cmd "heroku sharing:add nico@heypal.com #{app_setup}"
  end

  task :addons do
    header_subsection 'Adding Heroku Addons'
    cmd_confirm "heroku addons:add deployhooks:email --recipient=#{EMAILS} --subject=\"[Heroku] {{app}} deployed\" --body=\"{{user}} deployed {{head}} to {{url}}\""
    cmd_confirm "heroku addons:add amazon_rds --url=#{DB_PATH}#{app}"
    cmd_confirm "heroku addons:add memcachier:dev"
    cmd_confirm "heroku addons:add newrelic:standard"
    cmd_confirm "heroku addons:add sendgrid:starter"
    cmd_confirm "heroku addons:add scheduler:standard"
  end

  task :addons_open_browser do
    # configure addons in the web
    header_subsection 'Configure Addons (open in browser)'
    cmd "heroku addons:open sendgrid #{app_setup}"
    # rake alerts:send_alert
    # rake refresh:all
    cmd "heroku addons:open scheduler #{app_setup}"
  end

  task :new_s3_bucket do
    header_subsection 'Creating Amazon S3 buckets'
    begin
      s3 = AWS::S3.new(:access_key_id => S3_ACCESS_KEY_ID, :secret_access_key => S3_SECRET_ACCESS_KEY)
      bucket = s3.buckets.create(app)
      puts " > Bucket #{app} successfully created".light_blue
    rescue Exception => e
      puts("[ERROR] #{e.message}".red)
      s3.buckets.each {|b| puts("  > #{b.name}".red) }
    end
  end

  task :new_database do
    header_subsection 'Creating database in RDS'
    cmd "heroku run rake db:create #{app_setup}"
  end

  task :new_database_setup do
    header_subsection 'Importing schema in db & creating initial data'
    cmd "heroku run rake db:setup #{app_setup}"
  end

  task :status do
    site_list.each do |site|
      commit_count = commits_behind(site)
      if commit_count == 0
        puts "[ Updated ] -- #{site}".green
      else
        puts "[#{commit_count} behind] -- #{site}".red
      end
    end
  end

  task :all_sites do
    site_list.each do |site|
      unless commits_behind(site) == 0
        cmd "rake deploy:full APP=#{site} | tee -a 'log/deploy.log'"
      end
    end
  end

  task :load_seeds do
    cmd "heroku run rake seeds:#{site_type(app).downcase} #{app_setup}"
  end

  task :tests_passing do
    require 'json'
    semaphore_url = "https://semaphoreapp.com/api/v1/projects/b6034116ec9990fdfd70b3f45bae9724a63e82ff/master/status?auth_token=kxmz4M2K2yFqAPKcbKPK"
    test_passing = Curl.get(semaphore_url).body_str
    JSON.parse(test_passing)['result']
  end


private
  def cmd(c)
    puts(" > #{c}".light_blue)
    system(c) || fail("Error")
  end

  def cmd_confirm(c)
    puts(" > #{c} #{app_confirm}".light_blue)
    system("#{c} #{app_confirm}") || fail("Error")
  end

  def header(m)
    puts
    puts("*".white*80)
    puts("*#{m.chomp.center(78)}*".white)
    puts("*".white*80)
  end

  def header_subsection(m)
    puts
    puts("-".cyan*80)
    puts("|#{m.chomp.center(78)}|".cyan)
    puts("-".cyan*80)
  end

  def commits_behind(site)
    %x[ git log #{site}/master..master --pretty=oneline --abbrev-commit | wc -l ].to_i
  end

  def tests_passing
    require 'json'
    semaphore_url = "https://semaphoreapp.com/api/v1/projects/b6034116ec9990fdfd70b3f45bae9724a63e82ff/master/status?auth_token=kxmz4M2K2yFqAPKcbKPK"
    test_passing = Curl.get(semaphore_url).body_str
    JSON.parse(test_passing)['result']
  end

  # Parses heroku.yml and return a list of keys, except default_config
  def site_list
    require 'psych'
    Psych.load_file('config/heroku.yml').delete_if {|k,v| k == "default_config" }.keys
  end

  # Returns Services/Properties for a given site based on heroku.yml
  def site_type(site)
    require 'psych'
    Psych.load_file('config/heroku.yml')["#{site}"]['config']['PRODUCT_CLASS_NAME']
  end
end