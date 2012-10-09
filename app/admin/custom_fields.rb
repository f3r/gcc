ActiveAdmin.register CustomField  do
  menu :label => "Custom Fields", :parent => 'Settings', :if => lambda { |tabs| current_active_admin_user.super_admin? }


  controller do
    actions :all, :except => [:show]
  end

  config.clear_sidebar_sections!

  config.sort_order = "position_asc"

  index do
    column :name
    column :required
    column :type
    column :label
    #column :hint
    column("Values") {|cf| truncate(cf.values)}
    #column :more_info_label
    #column :validations
    #column("Date format") {|cf| cf.date? ? cf.date_format : ""}
    default_actions({:name => "Actions"})
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :type_cd, :as => :select, :collection => CustomField.types, :include_blank => false
      f.input :required
      f.input :label
      f.input :hint
      f.input :prefix, :hint => "[Optional] This value will be prefixed with the value the user inputs"
      f.input :validations, :hint => "Don't include validate[]! For validations reference: <a href = 'http://posabsolute.github.com/jQuery-Validation-Engine/#validators', target = '_blank'> link </a>".html_safe
      f.input :date_format, :as => :select, :collection => CustomField.DATE_FORMATS, :hint => "Only valid with date fields", :include_blank => false
      f.input :values
      f.input :more_info_label, :hint => "Only valid with Yes_No_Text field"
    end
    f.buttons
  end

  collection_action :sort, :method => :post do
    params[:custom_field].each_with_index do |id, index|
      CustomField.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

end
