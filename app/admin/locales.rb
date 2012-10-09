ActiveAdmin.register Locale do
  menu :parent => 'Settings'
  config.sort_order = 'position_asc'
  config.clear_sidebar_sections!

  scope :all, :default => true
  scope :active
  scope :inactive

  form do |f|
    f.inputs do
      f.input :code
      f.input :name
      f.input :name_native
      f.input :active
    end
    f.buttons
  end

  index do
    id_column
    column :name
    column :name_native
    column("Status")      {|locale| status_tag(locale.active ? 'Active' : 'Inactive') }
    default_actions
  end

  collection_action :sort, :method => :post do
    params[:locale].each_with_index do |id, index|
      Locale.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  # Activate/Deactivate
  action_item :only => :show do
    if locale.active
      link_to 'Deactivate', deactivate_admin_locale_path(locale), :method => :put
    else
      link_to 'Activate', activate_admin_locale_path(locale), :method => :put
    end
  end

  member_action :activate, :method => :put do
    locale = Locale.find(params[:id])
    activated = locale.activate!
    redirect_to({:action => :show}, :notice => (activated ? "The locale was activated" : "The locale cannot be activated"))
  end

  member_action :deactivate, :method => :put do
    locale = Locale.find(params[:id])
    activated = locale.deactivate!
    redirect_to({:action => :show}, :notice =>"The locale was deactivated")
  end
end
