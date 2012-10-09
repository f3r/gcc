ActiveAdmin.register DjClub do
  menu :parent => 'CMS'
  filter :name
  index do
    id_column
    column :name
    column("description") { |club| truncate(club.description) }
    column 'Photo1', :sortable => false do
    |club|
      image_tag(club.photo1.url(:medium))
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
      f.input :photo1, :hint => (f.template.image_tag(f.object.photo1.url(:medium)))
    end
    f.buttons
  end
end