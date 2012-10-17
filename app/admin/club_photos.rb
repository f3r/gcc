ActiveAdmin.register ClubPhoto do
  menu false
  belongs_to :dj_club

  form do |f|
    f.inputs do
      f.input :photo
    end
    f.buttons
  end
end