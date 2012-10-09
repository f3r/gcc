ActiveAdmin.register Gallery do
  menu :parent => 'CMS'
  filter :name

  controller do
    def update
      update! do |format|
          format.html { redirect_to admin_gallery_gallery_items_path(resource) }
        end
    end

    def show
      redirect_to admin_gallery_gallery_items_path(resource)
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :transition_speed, :hint => "In miliseconds"
    end
    f.buttons
  end
end
