ActiveAdmin.register Currency do
  menu :parent => 'Settings'

  config.sort_order = 'position_asc'

   controller do
    helper 'admin/currencies'
    def scoped_collection
      Currency.unscoped
    end
  end

  scope :all, :default => true
  scope :active
  scope :inactive

  filter :name
  filter :currency_code

  form do |f|
    f.inputs do
      f.input :name
      f.input :symbol
      f.input :currency_code
      f.input :currency_abbreviation, :label => "Currency Short Name", :hint => "Usually the 2-letter country code, e.g. for USD, the short name is US"
      f.input :country
      f.input :active
    end
    f.buttons
  end


  index do
    id_column
    column :name
    column :symbol
    column :currency_code
    column :currency_abbreviation
    column :country
    column("Status")      {|currency| status_tag(currency.active ? 'Active' : 'Inactive') }
    column("Actions")     {|currency| currency_links_column(currency) }
  end

  # Activate/Deactivate
  action_item :only => :show do
    if currency.active
      link_to 'Deactivate',deactivate_admin_currency_path(currency),  :method => :put
    else
      link_to 'Activate', deactivate_admin_currency_path(currency),:method => :put
    end
  end

  member_action :activate, :method => :put do
    currency = Currency.find(params[:id])
    activated = currency.activate!
    redirect_to({:action => :show}, :notice => (activated ? "The Currency was activated" : "The Currency cannot be activated"))
  end

  member_action :deactivate, :method => :put do
    currency = Currency.find(params[:id])
    activated = currency.deactivate!
    redirect_to({:action => :show}, :notice =>"The Currency was deactivated")
  end

   collection_action :sort, :method => :post do
    params[:currency].each_with_index do |id, index|
      Currency.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  collection_action :import_csv, :method => :post do
    if !params[:dump].blank? && !params[:dump][:file].blank?
      imported = CsvImport.parse_file(Currency, params[:dump][:file])
      flash[:success] = "Imported #{imported} rows"
    else
      flash[:success] = "You must select a file"
    end
    redirect_to :action => :index
  end
  
  sidebar :import_csv_file do
    render "admin/csv/upload_csv", :required_columns => "name, symbol, currency_code, currency_abbreviation, country"
  end

end
