class PreviewMails < MailView

  ###############################################################
  # REGISTRATION_MAILER
  ###############################################################
  def welcome_consumer
    user = getUser()
    RegistrationMailer.welcome_instructions(user)
  end

  def welcome_agent
    user = getUser()
    user.role = 'agent'
    RegistrationMailer.welcome_instructions(user)
  end

  def reset_password
    user = getUser()
    RegistrationMailer.reset_password_instructions(user)
  end

  def reset_password_reminder
    user = getUser()
    UserMailer.password_reset_reminder(user)
  end

  def new_question
    user = getUser()
    question = getComment()
    UserMailer.new_question(user, question)
  end

  def new_question_reply
    question = getComment()
    user = question.user
    UserMailer.new_question_reply(user, question)
  end

  # def confirmation_instructions
  #   user = User.first
  #   RegistrationMailer.confirmation_instructions(user)
  # end

  ###############################################################
  # USER_MAILER
  ###############################################################
  def auto_welcome
    user = getUser()
    UserMailer.auto_welcome(user)
  end

  def new_message_reply
    user = getUser()
    UserMailer.new_message_reply(user, getMessage())
  end

  ###############################################################
  # INQUIRY_MAILER
  ###############################################################
  def inquiry_confirmed_renter
    InquiryMailer.inquiry_confirmed_renter(an_inquiry)
  end

  def inquiry_confirmed_owner
    InquiryMailer.inquiry_confirmed_owner(an_inquiry)
  end

  def inquiry_reminder_owner
    InquiryMailer.inquiry_reminder_owner(an_inquiry)
  end

  ###############################################################
  # TRANSACTION_MAILER
  ###############################################################
  def transaction_request_renter
    TransactionMailer.request_renter(an_inquiry)
  end

  def transaction_request_owner
    TransactionMailer.request_owner(an_inquiry)
  end

  def transaction_approve_renter
    TransactionMailer.approve_renter(an_inquiry)
  end

  def transaction_approve_owner
    TransactionMailer.approve_owner(an_inquiry)
  end

  def transaction_pay_renter
    TransactionMailer.pay_renter(an_inquiry)
  end

  def transaction_pay_owner
    TransactionMailer.pay_owner(an_inquiry)
  end

  def search_alert
    alert = getAlert()
    user = getUser()
    alert.search = getSearch()
    city = getCity()

    if Alert.last.present?
      new_results = alert.search.resource_class.limit(2).all
      recently_added = alert.search.resource_class.limit(2).offset(2).all
    else
      new_results = getNewProducts()
      recently_added = getRecentProducts()
    end
    AlertMailer.send_alert(user, alert, city, new_results, recently_added)
  end

  private

  def an_inquiry
    inquiry = Inquiry.new(
      :created_at => 2.days.ago,
      :product => getProduct(),
      :user => getUser(),
      :check_in => 1.month.from_now.to_date,
      :length_stay => 1,
      :length_stay_type => 'months',
      :extra => {
        :name => 'Consumer',
        :email => 'consumer@email.com'
      }
    )
    conversation = Conversation.new( {:id => 1}, :without_protection => true )
    conversation = mark_it_saved(conversation)
    inquiry.define_singleton_method(:conversation, proc { conversation })
    inquiry
  end

  def getUser
    user = User.new(
      :email => "preview@heypal.com",
      :first_name => "Heypal",
      :last_name => "SE",
      :birthdate  => Date.current - 20.year ,
      :password => "heypal_preview",
      :password_confirmation => "heypal_preview",
      :confirmed_at  => 1.day.ago ,
      :role => "user")
  end

  def getComment
    product, property = setup_property_product
    comment = Comment.new({
      :id => -1,
      :user => getUser(),
      :comment => "Mail preview comments",
      :product => product}, :without_protection => true)
    comment = mark_it_saved(comment)
    comment
  end

  def getSearch
    search = Property.searcher.new(:city_id => getCity())
  end

  def setup_property_product
    product = Product.new({
      :id => -1,
      :as_product_id => -1,
      :as_product_type => "Property",
      :user_id => -1,
      :title => "Mail preview test product title",
      :description =>"Mail preview description",
      :address_1   => "Heypal",
      :address_2  => "Search engine",
      :zip  => "123456",
      :currency => getCurrency(),
      :city => getCity(),
      :price_per_month => 1000},:without_protection => true)

     product = mark_it_saved(product)

     property = Property.new({
      :id => -1,
      :title => "Mail preview test property title",
      :currency => getCurrency(),
      :city => getCity()
      },:without_protection => true)

     property = mark_it_saved(property)

     product.as_product = property

     [product, property]
  end

  def mark_it_saved(record)
    record.instance_variable_set '@new_record', false
    record
  end

  def getProduct
    property = Property.new({
      :id => 1,
      :as_product_id => 1,
      :as_product_type => "Property",
      :user => getUser(),
      :title => "Mail preview title",
      :description =>"Mail preview description",
      :address_1   => "Heypal",
      :address_2  => "Search engine",
      :zip  => "123456",
      :currency => getCurrency(),
      :city => getCity(),
      :price_per_month => 1000},:without_protection => true)

      property = mark_it_saved(property)
      product = property.product
      product = mark_it_saved(product)
      product
  end

  def getMessage
    message = Message.new(:body => "Mail Preview message body", :from => getUser())
  end

  def getCity

    return City.active.first if City.active.first.present?

    city = City.new(
      :name => 'Singapore',
      :country => 'Singapore',
      :slug => 'singapore',
      :cached_complete_name => 'Singapore,Singapore',
      :active  => true)
  end

  def getCurrency

    return Currency.active.first if Currency.active.first.present?

    currency = Currency.new(
      :name   => 'Dollar',
      :symbol => '$' ,
      :country => 'United States',
      :active  => 1,
      :currency_code => 'USD',
      :currency_abbreviation => 'USD'
    )
  end

  def getAlert
    return Alert.last if Alert.last.present?

    alert = Alert.new({
      :id => -1,
      :user => getUser(),
      :query => {'currency' => 'USD', 'guests' => "1"} ,
      :alert_type => 'Property',
      :active => 1,
      :role => 'user',
      :delivery_method => 'email',
      :schedule => 'monthly',
      :search_code => '120429MQ0F3A'
    },:without_protection => true)

    alert = mark_it_saved(alert)
    alert
  end

  def getNewProducts
    newProductArray = Array.new
    newProductArray << getProduct()
    newProductArray << getProduct()
    newProductArray
  end

  def getRecentProducts
    recentArray = Array.new
    recentArray << getProduct()
    recentArray << getProduct()
    recentArray
  end
end
