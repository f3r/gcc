ActiveAdmin.register City do
  menu :parent => 'Settings'

  config.sort_order = 'position_asc'

  controller do
    helper 'admin/cities'
    actions :index, :create, :show, :edit, :update

    def scoped_collection
      City.unscoped
    end
  end

  scope :all, :default => true
  scope :active
  scope :inactive

  filter :name
  filter :state
  filter :country, :as => :select, :collection => proc { City.select(["country as name"]).find(:all, :group => "country_code") }

  form :partial => "new"

  index do
    id_column
    column :name
    column :state
    column :country
    column("Status")      {|city| status_tag(city.active ? 'Active' : 'Inactive') }
    column("Actions")     {|city| city_links_column(city) }
  end

  show do
    attributes_table do
      rows :name, :state, :country, :active
      row('Map'){|city|  static_image_map(city)}
    end
  end

  collection_action :sort, :method => :post do
    params[:city].each_with_index do |id, index|
      City.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  # Activate/Deactivate
  action_item :only => :show do
    if city.active
      link_to 'Deactivate', deactivate_admin_city_path(city), :method => :put
    else
      link_to 'Activate', activate_admin_city_path(city), :method => :put
    end
  end

  member_action :activate, :method => :put do
    city = City.find(params[:id])
    activated = city.activate!
    redirect_to({:action => :show}, :notice => (activated ? "The city was activated" : "The city cannot be activated"))
  end

  member_action :deactivate, :method => :put do
    city = City.find(params[:id])
    activated = city.deactivate!
    redirect_to({:action => :show}, :notice =>"The city was deactivated")
  end

  collection_action :import_csv, :method => :post do
    if !params[:dump].blank? && !params[:dump][:file].blank?
      imported = CsvImport.parse_file(City, params[:dump][:file])
      flash[:success] = "Imported #{imported} rows"
    else
      flash[:success] = "You must select a file"
    end
    redirect_to :action => :index
  end


  collection_action :geonames_search, :method => :get do
    name = params[:geo_search][:name] if params[:geo_search]
    country_code = params[:geo_search][:country_code] if params[:geo_search]

    @results = City.geonames_search(name, country_code)
    render 'admin/cities/results'
  end

  action_item :only => :index do
    link_to 'Add new', geonames_search_admin_cities_path
  end

  # sidebar :import_csv_file do
  #   render "admin/csv/upload_csv", :required_columns => "name, state, country, country_code"
  # end

  sidebar "Translations", :only => :edit do
    div do
      b do
        resource.I18n_code
      end
    end
    table_for(Locale.all) do |t|
      t.column("Locale") {|v| v.code}
      t.column("Value") do |v|
        key = Translation.where(:locale => v.code, :key => resource.I18n_code).first
        if key.nil?
          link_to "Create", new_admin_translation_path(:locale => v.code, :key => resource.I18n_code)
        else
          "#{key.value} #{link_to('Edit', redirect_edit_admin_translations_path(:locale => v.code, :key => resource.I18n_code))}".html_safe
        end
      end
    end
  end
end
