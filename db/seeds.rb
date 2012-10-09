USERS = [
  ['Jeremy Snyder',       'jeremy.a.snyder@gmail.com'],
  ['Fer Santana',         'fernandomartinsantana@gmail.com'],
  ['Nicolas Gaivironsky', 'nico@heypal.com']
]

###############################################################################
# CREATING SITE CONFIGURATION
###############################################################################
site_config = SiteConfig.first_or_create
site_config.logo = File.open("#{Rails.root}/db/rake_seed_images/logo.png") unless site_config.logo?
site_config.fav_icon = File.open("#{Rails.root}/db/rake_seed_images/favicon.png") unless site_config.fav_icon?
site_config.photo_watermark = File.open("#{Rails.root}/db/rake_seed_images/logo-watermark.png") unless site_config.photo_watermark?
site_config.custom_meta ||= %{
  <meta name="robots" content="noodp" />
  <meta name="slurp" content="noydir" />
}
site_config.static_assets_path ||= "http://s3.amazonaws.com/#{Paperclip::Attachment.default_options[:bucket]}/static"
site_config.mailer_sender      ||= 'The Sharing Engine <noreply@thesharingengine.com>'
site_config.mail_bcc           ||= USERS.collect{|n, e| e}.join(', ')
site_config.support_email      ||= 'support@thesharingengine.com'
site_config.save!

###############################################################################
# CREATING LOCALES
###############################################################################
unless Locale.exists?(:code => "en")
  Locale.create!({
    :code        => "en",
    :name        => "English",
    :name_native => "English",
    :position    => 1,
    :active      => true
  })
end

###############################################################################
# CREATING CITIES
###############################################################################
unless City.exists?(name: "Singapore")
  City.create!({
    :name         => "Singapore",
    :lat          => 1.28967,
    :lon          => 103.85,
    :country      => "Singapore",
    :country_code => "SG",
    :active       => true
  })
end

###############################################################################
# CREATING CURRENCIES
###############################################################################
unless Currency.exists?(currency_code: "USD")
  Currency.create!({
    :name                  => "Us Dollar",
    :symbol                => "$",
    :country               => "USA",
    :currency_code         => "USD",
    :active                => 1,
    :position              => 1,
    :currency_abbreviation => "US"
  })
end

###############################################################################
# CREATING PREFERENCE SECTIONS
###############################################################################
unless PreferenceSection.any?
  PreferenceSection.create!({:name => "Language", :code => "language_pref", :position => 1, :active => true})
  PreferenceSection.create({:name => "Currency", :code => "currency_pref", :position => 2, :active => true})
  PreferenceSection.create({:name => "Size Unit", :code => "size_unit_pref", :position => 3, :active => true})
  PreferenceSection.create({:name => "Speed Unit", :code => "speed_unit_pref", :position => 4, :active => true})
end

###############################################################################
# CREATING GALLERIES
###############################################################################
unless Gallery.exists?(name: "homepage")
  home_gallery = Gallery.create!(name: "homepage")
  home_gallery.gallery_items.create!(
  	photo: File.open("#{Rails.root}/db/rake_seed_images/carousel.png"),
  	link: "http://www.thesharingengine.com",
  	label: 'Get Started Today!',
  	position: 1,
  	active: 1
  )
end

###############################################################################
# CREATING DEFAULT ADMIN USERS
###############################################################################
USERS.each do |name, email|
  unless User.exists?(email: email)
    u = User.new
    u.name         = name
    u.email        = email
    u.role         = 'superadmin'
    u.password     = '3ngin3'
    u.skip_welcome = true
    u.save!
  end
end

###############################################################################
# CREATING SITE MENUS
###############################################################################
MENUS = [
  ["main",          "main",       "Menu for users that are not signed in"],
  ["help",          "help",       "Menu for additional help topics"],
  ["footer",        "footer",     "Footer links"],
  ["menu_consumer", "User Menu",  "Menu for consumers users"],
  ["menu_agent",    "Agent Menu", "Menu for agent users"]
]

MENUS.each do |name, display_name, description|
  next if MenuSection.exists?(name: name)
  MenuSection.create!({
    :name         => name,
    :display_name => display_name,
    :description  => description
  })
end


###############################################################################
# CREATING CMS PAGES
###############################################################################
unless Cmspage.count >= 10
  # Render a haml view
  app = HeyPalFrontEnd::Application
  app.routes.default_url_options = { :host => '' }
  controller = ApplicationController.new
  view = ActionView::Base.new("db/pages", {}, controller)
  view.class_eval do
    include ApplicationHelper
    include app.routes.url_helpers
  end

  # Format: [title, url (, menu_name)]
  pages = [
    ['Error - 404',         'error_404'],
    ['Error - 500',         'error_500'],
    ['Fees',                'fees'],
    ['Home page - Footer',  'home_page_footer'],
    ['Terms',               'terms',        'footer'],
    ['Privacy Policy',      'privacy',      'footer'],
    ['Contact Information', 'contact',      'footer'],
    ['How it works',        'how-it-works', 'help'],
    ['Why',                 'why',          'help'],
    ['Home page - Right',   'home_page_right']
  ]

  pages.each do |title, url, menu_name|
    next if Cmspage.exists?(page_url: url)

    html = view.render(template: url)
    page = Cmspage.create!(
      page_title:  title,
      page_url:    url,
      description: html,
      active:      true,
      mandatory:   true
    )
    if menu_name
      menu = MenuSection.find_by_name(menu_name)
      menu.cmspages << page
    end
  end
end
