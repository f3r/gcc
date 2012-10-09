ActiveAdmin.register FrontCarrousel, :as => "Frontpage image" do
  menu false
  actions :all, :except => :new
  
  config.sort_order = 'active_desc'
  filter :label
  
  index :title => 'Frontpage image gallery' do
    id_column
    column :link
    column :label
    column 'IMAGE', :sortable => false  do 
      |fc| image_tag(fc.photo.url('tiny'))
      end
    column "Visible", :sortable => :active do
      |fc| status_tag(fc.active ? 'Yes' : 'No')
      end
    column :created_at 
    default_actions
  end
  
  show do |fc|
    attributes_table do
      row :id    
      row :link
      row :label
      row("IMAGE") do
         image_tag(fc.photo.url)
      end
      row("Visible") do
         status_tag(fc.active ? 'Yes' : 'No')
      end 
      row :created_at
    end
  end  
  
  form do |f|
    f.inputs do
      f.input :link
      f.input :label
      f.input :photo
      f.input :active, :label => "Visible?"
    end
    f.buttons
  end  
  
  action_item :except=> :new_set do
    link_to 'Add photos', "/admin/frontpage_images/new_set"
  end
  
  collection_action :new_set, :method => :get do
    @page_title = "Add photos"
  end
  
  collection_action :new_set_upload, :method => :post do
    new_fc = FrontCarrousel.new(:photo => params[:Filedata]) 
    new_fc.save
    render :nothing => true
  end

  collection_action :sort, :method => :post do
    params[:front_carrousel].each_with_index do |id, index|
      FrontCarrousel.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
end
