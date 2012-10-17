ActiveAdmin.register DjClub do
  menu :parent => 'CMS'
  filter :name
  filter :city
  index do
    id_column
    column :name
    column("description") { |club| truncate(club.description) }
    column 'Photo1', :sortable => false do
    |club|
      image_tag(club.primary_photo.photo.url(:medium))
    end
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :address
      f.input :location
      f.input :email
      f.input :phone
      f.input :website
      f.input :points
    end
    f.buttons
  end

  action_item :except => [:show, :index] do
    link_to "Add/Edit Photos", admin_dj_club_club_photos_path(params[:id])
  end

end