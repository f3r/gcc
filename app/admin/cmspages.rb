ActiveAdmin.register Cmspage  do
  menu :label => "Pages", :parent => 'CMS'

  controller do
    actions :all
  end

  config.sort_order = 'id_asc'

  scope :all, :default => true
  scope :active
  scope :inactive
  scope "System" do |pages|
    pages.system
  end

  filter :page_title

  controller do
    helper 'admin/cmspages'

    def new
      unless params[:frommenu].nil?
        session[:frommenu] = params[:frommenu]
      end
      new!
    end
    
    def show
      redirect_to edit_admin_cmspage_path(resource)
    end

    def create
      create! do |format|
        frommenu = session[:frommenu]
        format.html do
          if frommenu.nil?
            super
          else
            session[:frommenu] = nil
            resource.active = true
            resource.save
            session[:newlink] = resource
            redirect_to admin_menu_section_path(frommenu)
          end
        end
      end
    end

    def destroy
      if resource.mandatory?
        redirect_to admin_cmspage_path, :notice => "Page not deletable"
      else
        super
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :page_title
      f.input :page_url , :label => "Page Url", :hint => cmspage.external? ? "This link will be opened in new window" : "Ex: if page url is 'how', the final url would be #{SiteConfig.site_url}/page/how"
      unless cmspage.external? #We don't need the description editor for externallinks
        f.input :description ,:input_html => {:class => 'tinymce'}
      end
      f.input :meta_keywords,
        :hint => "Add all keywords that describe your site. Separated by commas",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
      f.input :meta_description,
        :hint => "Create a description of your site for search engines",
        :input_html => { :class => 'autogrow', :rows => 4, :cols => 20}
      f.input :active
    end
    f.buttons
  end

  index do
    column(:id){|cmspage| link_to cmspage.id, edit_admin_cmspage_path(cmspage) }
    column :page_title
    column :page_url
    column("description")  {|cmspage| truncate(cmspage.description)}
    column :meta_keywords
    column :meta_description
    column("Status")       {|cmspage| status_tag(cmspage.active ? 'Active' : 'Inactive') }
    column("Actions") {|cmspage| cmspage_links_column(cmspage)}
  end

  action_item  do
      link_to 'New External Link', new_admin_external_link_path
  end
  
  collection_action :image_upload, :method => :post do
    #TODO: Do we need to store the cmspage id?    
    cmspage_image = CmspageImage.create(:image => params[:file])
    render :text => { :filelink => cmspage_image.image.url }.to_json
  end
  
  collection_action :images, :method => :get do
    images = []
    CmspageImage.all.each do |cms_image|
      images << {"thumb" => cms_image.image.url(:thumb), "image" => cms_image.image.url}
    end
    render :text => images.to_json
  end

  sidebar "Versions", :only => :edit do
    unless resource.external? || resource.cmspage_versions.nil?
      table_for(resource.cmspage_versions) do |t|
        t.column("Choose a version") {|v| link_to v.display_name, admin_cmspage_version_path(v), :remote => true}
      end
    end
  end
end
