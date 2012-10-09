require 'securerandom'
class Alert < ActiveRecord::Base

  validates_presence_of [:user_id, :schedule]
  validates_inclusion_of :delivery_method, :in => ["email", "sms", "email_sms"]
  validates_inclusion_of :schedule,        :in => ["daily", "weekly", "monthly"]

  before_create :set_search_code
  before_create :set_delivered_at
  before_create :set_alert_type

  belongs_to :user
  belongs_to :search, :class_name => Search::Base

  # For saving the result_ids
  serialize :results

  accepts_nested_attributes_for :search

  default_scope where(:deleted_at => nil)

  def self.send_alerts
    alerts = Alert.where(["((schedule = ? AND delivered_at < ?) OR (schedule = ? AND delivered_at < ?) OR (schedule = ? AND delivered_at < ?)) AND active and alert_type = ?",
                          "daily",   Time.now - 1.day,
                          "weekly",  Time.now - 1.week,
                          "monthly", Time.now - 1.month,
                          SiteConfig.product_name.capitalize
                          ])

    count = 0
    alerts.each do |alert|
      if alert.valid_alert?
        new_results    = []
        recently_added = []
        city           = City.find(alert.search.city_id)
        new_results    = alert.get_results({:search_type => "new_results"})
        recently_added = alert.get_results({:search_type => "recently_added"}, new_results)
        if new_results.present? or recently_added.present?
          mailer = AlertMailer.send_alert(alert.user, alert, city, new_results, recently_added)
          if mailer.deliver
            alert.update_delivered(new_results)
            count += 1
          end
        end
      end
    end
    count
  end

  # keeps alerts for a while, avoids breaking links sent through email
  def soft_delete
    ActiveRecord::Base.record_timestamps = false
    self.deleted_at = Time.now
    self.save
    ActiveRecord::Base.record_timestamps = true
  end

  def valid_alert?
    #TODO Check if the alert is still valid
    true
  end

  def update_delivered(new_results)
    new_results_ids = new_results.map{|x| x[:id]}
    results_ids = []
    results_ids = self.results if self.results.present?
    results_ids += new_results_ids
    ActiveRecord::Base.record_timestamps = false
    self.update_attributes({:delivered_at => Date.today, :results => results_ids})
    ActiveRecord::Base.record_timestamps = true
  end


  def get_results(opts = {}, prev_results = nil)
    search = self.search
    resource_class = search.resource_class
    if opts[:search_type] == "new_results"
      exclude_ids = self.results
      if exclude_ids.present?
        search.exclude_ids = exclude_ids
      end
    elsif opts[:search_type] == "recently_added"
      search.date_from = self.delivered_at
    end
    search.exclude_ids = prev_results.map{|r| r[:id]} if prev_results.present?
    get_full_results(search)
  end

  private
  def set_search_code
    self.search_code = generate_search_code
  end

  def set_alert_type
    self.alert_type = SiteConfig.product_class.name
  end

  # used for short url
  def generate_search_code
    search_code = Time.now.strftime("%y%m%d#{SecureRandom.urlsafe_base64(4).upcase}")
    # We make sure the search code is unique
    if Alert.find_by_search_code(search_code)
      self.generate_search_code
    else
      search_code
    end
  end

  # set initial delivery day as today.
  def set_delivered_at
    self.delivered_at = Date.today
  end

  def get_full_results(search)
    results  = []
    search.clear_results
    results += search.results.all.to_a
    total_pages = search.total_pages
    for page in (2..total_pages)
      search.clear_results
      search.current_page = page
      results += search.results.all.to_a
    end
    results
  end

end
