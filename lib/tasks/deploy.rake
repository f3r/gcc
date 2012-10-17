namespace :deploy do
  DB_PATH   = "mysql2://heypaladmin:HYpl99db@heypal-useast-1.c7xsjolvk9oh.us-east-1.rds.amazonaws.com/"
  EMAILS    = "fer@heypal.com,nico@heypal.com"
  S3_ACCESS_KEY_ID     = 'AKIAJOJEIAZ6LOVHDFDA'
  S3_SECRET_ACCESS_KEY = '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'

  def app
    "djconnect-tse"
  end

  def app_setup
    "--app #{app}"
  end

  task :default => [:push]
  task :full    => [:push_config, :push, :migrate, :restart]

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

  task :migrate do
    header 'Running database migrations ...'
    cmd "heroku run rake db:migrate #{app_setup}"
  end

  task :restart do
    header 'Restarting app servers ...'
    cmd "heroku restart #{app_setup}"
  end

  task :status do
    commit_count = %x[ git log #{app}/master..master --pretty=oneline --abbrev-commit | wc -l ].to_i
    if commit_count == 0
      puts "[ Updated ] -- #{site}".green
    else
      puts "[#{commit_count} behind] -- #{site}".red
    end
  end

  task :off do
    header 'Putting the app into maintenance mode ...'
    cmd "heroku maintenance:on #{app_setup}"
  end

  task :on do
    header 'Taking the app out of maintenance mode ...'
    cmd "heroku maintenance:off #{app_setup}"
  end

  task :tests_passing do
    # TODO: put this back if we get semaphoreapp for GCC
    tests_passing
  end

private
  def cmd(c)
    puts(" > #{c}".light_blue)
    system("#{c} | tee -a 'log/deploy.log'") || fail("Error")
  end

  def header(m)
    puts
    puts("*".white*80)
    puts("*#{m.chomp.center(78)}*".white)
    puts("*".white*80)
  end

  def commits_behind(site)

  end

  def tests_passing
    # TODO: put this back if we get semaphoreapp for GCC
    # require 'json'
    # semaphore_url = "https://semaphoreapp.com/api/v1/projects/b6034116ec9990fdfd70b3f45bae9724a63e82ff/master/status?auth_token=kxmz4M2K2yFqAPKcbKPK"
    # test_passing = Curl.get(semaphore_url).body_str
    # JSON.parse(test_passing)['result']
  end
end