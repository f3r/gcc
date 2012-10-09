ActiveAdmin.register Category do
  menu :parent => 'Settings'
  filter :name

  index do
    id_column
    column :name
    default_actions
  end

  collection_action :import_csv, :method => :post do
    if !params[:dump].blank? && !params[:dump][:file].blank?
      imported = CsvImport.parse_file(Category, params[:dump][:file])
      flash[:success] = "Imported #{imported} rows"
    else
      flash[:success] = "You must select a file"
    end
    redirect_to :action => :index
  end
  
  sidebar :import_csv_file do
    render "admin/csv/upload_csv", :required_columns => "name"
  end

end