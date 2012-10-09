ActiveAdmin.register PreferenceSection do
  menu :label => "Preference Section", :parent => 'Settings'

  config.sort_order = 'position_asc'

  controller do
    helper 'admin/preference_sections'
    def scoped_collection
      PreferenceSection.unscoped
    end
  end

  scope :all, :default => true
  scope :active
  scope :inactive

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :code
      f.input :active
    end
    f.buttons
  end

  index do
    id_column
    column :name
    column :code
    column("Status")      {|preference_section| status_tag(preference_section.active ? 'Active' : 'Inactive') }
    column("Actions")     {|preference_section| preference_section_links_column(preference_section) }
  end

  collection_action :sort, :method => :post do
    params[:preference_section].each_with_index do |id, index|
      PreferenceSection.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  # Activate/Deactivate
  action_item :only => :show do
    if preference_section.active
      link_to 'Deactivate', deactivate_admin_preference_section_path(preference_section), :method => :put
    else
      link_to 'Activate', activate_admin_preference_section_path(preference_section), :method => :put
    end
  end

  member_action :activate, :method => :put do
    preference_section = PreferenceSection.find(params[:id])
    activated = preference_section.activate!
    redirect_to({:action => :show}, :notice => (activated ? "The preference section was activated" : "The preference section cannot be activated"))
  end

  member_action :deactivate, :method => :put do
    preference_section = PreferenceSection.find(params[:id])
    activated = preference_section.deactivate!
    redirect_to({:action => :show}, :notice =>"The preference section was deactivated")
  end

end
