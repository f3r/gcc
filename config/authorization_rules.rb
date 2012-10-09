authorization do
  role :superadmin do
    includes [:admin]
  end

  role :admin do
    includes [:default, :agent, :user]
    has_permission_on [:users, :products, :categories, :addresses, :bank_accounts, :availabilities, :comments], :to => [:manage]
    has_permission_on :users, :to => [:change_role]
  end

  role :agent do
    includes [:default]
    has_permission_on :properties, :to => [:create]
    has_permission_on :properties, :to => [:manage, :publish, :user_places] do
      if_attribute :user => is { user }
    end
    has_permission_on :product, :to => [:create]
    has_permission_on :products, :to => [:manage, :publish, :user_places] do
      if_attribute :user => is { user }
    end
    has_permission_on :services, :to => [:manage] do
      if_attribute :user => is { user }
    end
    has_permission_on [:availabilities, :comments], :to => [:manage] do
      if_permitted_to :manage, :product
    end
    has_permission_on :transactions, :to => [:update, :decline, :pre_approve] do
      if_permitted_to :manage, :product
    end
    has_permission_on :bank_accounts, :to => [:manage] do
      if_attribute :user => is { user }
    end
    has_permission_on :photos, :to => [:manage, :sort]
  end

  role :user do
    includes [:default]
    has_permission_on :conversations,   :to => [:index, :show, :update, :mark_as_unread, :unread_count]
    has_permission_on :alerts, :to => [:manage] do
      if_attribute :user => is { user }
    end
    has_permission_on :transactions,  :to => [:update, :request, :pay] do
      if_attribute :user_id => is { user.id }
    end
  end

  role :default do
    includes [:guest]
    has_permission_on [:users], :to => [:read, :update, :delete, :transactions] do
      if_attribute :id => is { user.id }
    end
    has_permission_on :addresses, :to => [:manage] do
      if_attribute :user => is { user }
    end
    has_permission_on :comments, :to => :create do
      if_attribute :replying_to => is { nil }
    end
    has_permission_on :comments, :to => :read do
      if_attribute :user => is { user }
    end
  end

  role :guest do
    has_permission_on :users,         :to => [:info, :feedback]
    has_permission_on :categories,    :to => :read
    has_permission_on :products,      :to => [:inquire]
    has_permission_on :products,      :to => :read do
      if_attribute :published => is { true }
    end
    has_permission_on :availabilities, :to => :read do
      if_permitted_to :read, :product
    end
    #has_permission_on :places, :to => :check_availability do
    #  if_permitted_to :read, :place
    #end
    has_permission_on :passwords,     :to => [:update, :create]
    has_permission_on :sessions,      :to => [:create, :oauth_create]
    has_permission_on :confirmations, :to => [:show, :create]
    has_permission_on :registrations, :to => [:create, :check_email]
    has_permission_on :comments, :to => :read do
      if_attribute :comments_count => gt { 0 }
    end
    has_permission_on :geo, :to => [:get_countries, :get_states, :get_cities, :get_city, :city_search, :price_range]
    has_permission_on :alerts, :to => [:get_params]
    has_permission_on :transactions,  :to => [:pay]
    has_permission_on :frontpage_images, :to => [:get_visible_images]
    has_permission_on :currencies,  :to => [:get_currencies]
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show, :list]
  privilege :create
  privilege :update
  privilege :delete, :includes => :destroy
end