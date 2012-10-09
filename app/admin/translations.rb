ActiveAdmin.register Translation do
  menu :parent => 'CMS'

  config.sort_order = 'key_asc'

  controller do
    #actions :all, :except => [:new, :create]
    helper 'admin/translations'
    def scoped_collection
      Translation.where(:locale => "en")
    end

    def search(chain)
      #By default the search is only done on en locale, we need to fix up the initial collection to use
      unless params[:q].nil?
        value_q = params[:q]["value_contains"]
        chain = Translation.order('') if value_q.present?
      end
      super
    end
  end

  filter :key
  filter :value

  scope :all, :default => true
  scope :template
  scope :places
  scope :users
  scope :workflow
  scope :inquiries
  scope :messages
  scope :mailers

  index do
    column(:key) {|translation|
      translation.key
    }
    for locale in Locale.all
      column(locale.code) {|translation| translation_value_with_links(translation, locale.code) }
    end
  end

  form :partial => "form"

  collection_action :clear_cache, :method => :get do
    I18n.cache_store.clear
    redirect_to({:action => :index}, :notice => "Cache cleared!")
  end

  collection_action :redirect_view, :method => :get do
    key = Translation.where(:locale => params[:locale], :key => params[:key]).first
    redirect_to admin_translation_path(key.id)
  end

  collection_action :redirect_edit, :method => :get do
    key = Translation.where(:locale => params[:locale], :key => params[:key]).first
    redirect_to edit_admin_translation_path(key.id)
  end

  action_item :only => :index do
    link_to('Clear Cache', clear_cache_admin_translations_path)
  end

  show do |ad|
    attributes_table do
      row :locale
      row :key
      row :value
      row :other_languages do
        render 'other_languages', :key => ad.key, :locale => ad.locale
      end
    end
    active_admin_comments
  end

  sidebar "Versions", :only => :edit, :if => proc{ !resource.versions.empty? } do
    table_for(resource.versions) do |t|
      t.column("Choose a version") {|v| link_to v.display_name, admin_translation_version_path(v), :remote => true, :title => v.value, :rel => 'tooltip' }
    end
  end

end