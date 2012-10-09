ActiveAdmin.register SiteConfig, :as => 'SeoEnhancements' do
  menu :label => "Seo Enhancement", :parent => 'Settings'

  controller do
    actions :index, :edit, :update

    def index
      redirect_to :action => :edit, :id => 1
    end

    def update
      update! do |format|
        format.html { redirect_to edit_resource_path(resource) }
      end
    end
  end

  form do |f|
    f.inputs "SEO Enhancement" do
      f.input :custom_meta,
        :label => "Custom Meta Tags",
        :hint => "Please add with the format: <META NAME= \"Your Meta Tag Key\" content=\"Your Meta Tag Content\"> -- Please visit http://en.wikipedia.org/wiki/Meta_element for more info",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
      f.input :meta_description, :hint => "Create a description of your site for search engines",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
      f.input :meta_keywords, :hint => "Add all keywords that describe your site. Separated by commas",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
    end
    f.buttons
  end
end