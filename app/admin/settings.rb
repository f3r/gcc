ActiveAdmin.register SiteConfig, :as => 'Settings' do
  menu :label => "Config", :parent => 'Settings'

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
    f.inputs "Basic Settings" do
      f.input :site_name
      f.input :site_url
      f.input :site_tagline
      f.input :mailer_sender
      f.input :support_email
    end

    f.inputs "Credentials for external services" do
      f.input :gae_tracking_code , :label=>"Google Analytics Tracking Code",
        :hint => (f.template.link_to('How to Integrate Google Analytics?', "https://tse.uservoice.com/knowledgebase/articles/119803-adding-google-analytics-to-your-site-on-the-sharin", :target => "_blank"))
      f.input :fb_app_id,          :label=>"Facebook App ID"
      f.input :fb_app_secret,      :label=>"Facebook Secret",
        :hint => (f.template.link_to('How to connect to Facebook?', "https://tse.uservoice.com/knowledgebase/articles/119406-facebook-sign-in-and-registration", :target => "_blank"))
      f.input :tw_app_id,         :label=>"Twitter App ID"
      f.input :tw_app_secret,     :label=>"Twitter Secret",
        :hint => (f.template.link_to('How to connect to Twitter?', "https://tse.uservoice.com/knowledgebase/articles/119412-twitter-sign-in-and-registration", :target => "_blank"))
    end

    f.inputs "Storage" do
      f.input :static_assets_path
    end

    f.inputs "Agent Approval" do
      f.input :agent_need_approval, :label=>"Agent need approval for Registration"
    end

    # We need to show the view selection only if the listing has both views defined
    if overridable_partial_defined?('grid')
      f.inputs "Search View" do
        f.input :search_default_view_type_cd, :label=>"Default search view type", :as => "select", :collection => SiteConfig.search_default_view_types, :include_blank => false
      end
    end

    f.inputs "Message Masking" do
      f.input :enable_message_masking, :label=>"Hide emails, phone numbers, etc in messages between users"
    end

    f.inputs "Show Contact Form" do
      f.input :show_contact, :label=>"Show Contact Form"
    end

    f.inputs "Images" do
      f.input :fav_icon, :hint => (f.template.image_tag(SiteConfig.fav_icon.url) if SiteConfig.fav_icon?)
      f.input :logo,     :hint => (f.template.image_tag(SiteConfig.logo.url)     if SiteConfig.logo?)
      # f.input :photo_watermark, :hint => (f.template.image_tag(SiteConfig.photo_watermark.url)\
      #  + f.template.link_to('Clear it', reset_field_admin_setting_path(resource) + "?f=photo_watermark",{:method => :put}) if SiteConfig.photo_watermark?)
    end

    f.buttons
  end

  member_action :reset_field, :method => :put do
    which_field = params[:f]

    unless which_field.nil?
      which_field = which_field + "="
      setting = SiteConfig.find(params[:id])
      if setting.present? and setting.respond_to?(which_field)
        setting.send(which_field, nil)
        setting.save
      end
    end

    redirect_to(edit_admin_setting_path(setting), :notice => "Field cleared")
  end

end