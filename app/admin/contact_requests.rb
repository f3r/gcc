ActiveAdmin.register ContactRequest do
  menu :priority => 6, :parent => 'E-Commerce'
  actions :index

  scope :all, :default => true

  filter :name
  filter :email
  filter :created_at

  index do |contact|
    id_column
    column :created_at
    column :name
    column :email
    column :message
  end
end