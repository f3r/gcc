ActiveAdmin.register SiteConfig, :as => 'CustomWidgets' do
  menu :label => "Custom Widgets", :parent => 'Settings'

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
    f.inputs "Page sections" do
      f.input :head_tag,
        :hint => "Code will be inserted inside the <head> </head>tag",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
      f.input :after_body_tag_start,
        :hint => "Code will be inserted just after the <body> tag",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
      f.input :before_body_tag_end,
        :hint => "Code will be inserted just before </body> tag",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
      f.input :sidebar_widget,
        :hint => "Code will be inserted just after the search filters",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
    end
    f.buttons
  end
end