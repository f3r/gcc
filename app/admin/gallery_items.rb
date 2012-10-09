ActiveAdmin.register GalleryItem  do
  menu false
  filter :label

  belongs_to :gallery

  config.sort_order = 'position_asc'

  controller do
    actions :edit, :update, :destroy, :show, :index
  end

  index do
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

  show do |gi|
    attributes_table do
      row :id
      row :link
      row :label
      row("IMAGE") do
         image_tag(gi.photo.url)
      end
      row("Visible") do
         status_tag(gi.active ? 'Yes' : 'No')
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

  action_item :except => :add_photos do
    @gallery = Gallery.find(params[:gallery_id])
    link_to "Add Photos", add_photos_admin_gallery_gallery_items_path(params[:gallery_id])
  end

  collection_action :add_photos do
    config.clear_action_items
    @gallery = Gallery.find(params[:gallery_id])
  end

  collection_action :add_photo, :method => :post do
    config.clear_action_items
    @gallery = Gallery.find(params[:gallery_id])
    gallery_item = @gallery.gallery_items.new(:photo => params[:file])
    gallery_item.save!
    render :nothing => true
  end

  collection_action :sort, :method => :post do
    params[:gallery_item].each_with_index do |id, index|
      GalleryItem.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end


end
