HeyPalFrontEnd::Application.routes.draw do
  get "dj_clubs/list"

  get 'sitemap.xml' => 'cached_sitemaps#sitemap'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  require_dependency 'preview_mails'
	match "/admin/mail_view" => PreviewMails, :anchor => false, :constraints => lambda { |request|
    request.env['warden'].authenticated?
    request.env['warden'].authenticate!
    %w(admin superadmin).include? request.env['warden'].user.role
  }

  root :to => 'home#index'

  devise_for :users,
             :controllers => { :sessions => 'sessions',
                               :registrations => 'registrations',
                               :passwords => 'passwords',
                               :omniauth_callbacks => "omniauth_callbacks"},
             :path_names => {  :sign_in => 'login',
                               :sign_up => 'signup',
                               :sign_out => 'logout' }

  resources :listings do
    member do
      put   :publish
      put   :unpublish
      put   :update_currency
      put   :update_address
      get   :publish_check
    end
    resources :photos, :only => [:create, :update, :destroy] do
      put :sort, :on => :collection
    end
  end

  resources :products do
    resources :questions do
      post :reply_to_message
    end
    resources :reviews, :only => [:create]
  end

  resources :image_cropper, :controller => :image_cropper, :only => [:new, :update, :create]

  ###########################################################################################
  # Inquiries
  ###########################################################################################
  resources :messages do
    member do
      put :mark_as_unread
    end
  end

  resources :inquiries, :only => [:new, :create, :edit, :update]
  resources :transactions, :only => [:update]
  match 'paypal_callback', :to => 'payment_notifications#create', :as => :paypal_callback

  ###########################################################################################
  # Profiles
  ###########################################################################################
  resource :profile do
    member do
      post :update_avatar
      post :crop_avatar
    end
  end

  resources :users, :only => [:show]
  put   '/set_ref'                    => 'home#set_ref'

  ###########################################################################################
  # Backend ported resources
  ###########################################################################################
  resources :favorites, :only => [:create, :destroy]
  get 'favorites/add' => 'favorites#create' # For after login redirect

  resources :search, :controller => 'Search', :only => [:index, :show] do
    collection do
      get :favorites
    end
  end

  resources :feedbacks, :only => [:new, :create]
  resources :contacts, :only => [:create]

  match '/:city'           => 'search#index', :city => City.routes_regexp
  match '/:city/:id'       => 'search#show',  :city => City.routes_regexp, :as => :city_product
  match '/worldwide'       => 'search#index', :global => 'all', :as => :global_results


  ###########################################################################################
  # Detecting untranslated strings
  ###########################################################################################
  if Rails.env.development?
    match 'translate'           => 'translate#index',     :as => :translate_list
    match 'translate/translate' => 'translate#translate', :as => :translate
    match 'translate/reload'    => 'translate#reload',    :as => :translate_reload
  end

   ###########################################################################################
  # Static page dynamic routing
  ###########################################################################################
  match '/terms'                    => 'home#staticpage' , :pages => :terms
  match '/fees'                     => 'home#staticpage' , :pages => :fees
  match '/privacy'                  => 'home#staticpage' , :pages => :privacy
  match '/alive'                    => 'home#alive'

  get '/robots.txt' => 'home#robot'

  # Error matching
  match '/404' => 'errors#page_not_found'
  match '/500' => 'errors#exception'

  match '/:pages' => 'home#staticpage'
end
