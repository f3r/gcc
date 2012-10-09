klass = SiteConfig.product_class

ActiveAdmin.register klass do
  menu :priority => 1, :parent => 'E-Commerce', :label => 'Listings'

  scope :all, :default => true
  scope :published
  scope :unpublished

  #We clear out the default search sidebar
  config.clear_sidebar_sections!

  # These are fixed
  filter :product_title
  filter :product_user_id, {:collection => Proc.new {User.all}}
  filter :product_city_id, {:collection => Proc.new {City.all}}

  #Extra filtered added here
  if klass.respond_to?('admin_filters')
    extra_filters = klass.admin_filters
    extra_filters.each do |fil|
      filter fil.to_sym
    end
  end

  controller do
    helper 'admin/products'
  end

  index do
    id_column
    column :title
    column :user
    column :city
    column :created_at
    column :updated_at
    column("Status")      {|p| status_tag(p.published ? 'Published' : 'Unpublished') }
    default_actions(:name => 'Actions')
  end

  show do
    resource_super_class_rows = resource.product.class.columns.collect{|column| column.name.to_sym }
    resource_super_class_rows = resource_super_class_rows.reject{|c| c =~ /id|created_at|updated_at|as_product_type/}
    rows = [:id] + resource_super_class_rows + default_attribute_table_rows.reject{|c| c =~ /id/}
    attributes_table *rows do
      row(:photos) {|p| product_photos_row(p)}
    end
    active_admin_comments
  end

  form :partial => "form"

  sidebar :filters, :only => :index do
    active_admin_filters_form_for assigns[:search], active_admin_config.filters, {:builder => HeyPalFrontEnd::ActiveAdmin::ProductFilterFormBuilder}
  end

end
