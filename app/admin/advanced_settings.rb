ActiveAdmin.register SiteConfig, :as => 'Advanced Settings' do
  menu :label => "Advanced Config", :parent => 'Settings', :if => lambda { |tabs| current_active_admin_user.super_admin? }

  controller do
    actions :index, :edit, :update

    def index
      redirect_to :action => :edit, :id => 1
    end

    def update
      update! do |format|
        format.html { redirect_to edit_resource_path(resource) }
      end
    end
  end

  form do |f|
    f.inputs "Advanced Settings" do
      f.input :color_scheme, :as => :select, :collection => SiteConfig.color_schemes, :include_blank => false
      f.input :mail_bcc
      f.input :fee_amount, :hint => '(Amount as total or percentage of the transaction amount)'
      f.input :fee_is_fixed, :as => :select, :collection => [['Fixed', true], ['Percentage', false]],
        :label => 'Fee type', :hint => '(Is the fee a fixed amount or a percentage of the transaction?)'
      f.input :charge_total, :hint => '(Charge the transaction total)'
      f.input :calendar, :hint => '(Show calendar tab and availability management)'
      f.input :show_powered, :label => 'Powered by TSE', :hint => '(Show powered by TSE in footer)'
      f.input :show_all_amenities, :hint => '(Show all amenities in product listings)'
      f.input :listing_photos_count, :hint => '(The minimum number of photos the listings should have)'
      f.input :gae_tracking_code_tse, :hint => 'TSE Google Analytics tracking code (independent of client)'
    end

    f.inputs "Pricing Units" do
      f.input :enable_price_sale
      f.input :enable_price_per_month
      f.input :enable_price_per_week
      f.input :enable_price_per_day
      f.input :enable_price_per_hour
    end
    f.buttons
  end
end
