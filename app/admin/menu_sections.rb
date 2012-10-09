ActiveAdmin.register MenuSection do
  menu    :label => "Menus", :parent => 'CMS'
  filter  :name
  actions :index, :show

  controller do
    def show
      unless session[:newlink].nil?
        resource.cmspages << session[:newlink]
        session[:newlink] = nil
      end

      selected_ids = resource.cmspages.all(:select => 'cmspages.id').map(&:id)
      selected_ids = [0] if selected_ids.empty?
      @available_pages = Cmspage.active.all(:conditions => ['id not in (?)', selected_ids], :order => 'page_title asc')
    end

  end

  index do
    id_column
    column :name
    column :display_name
    column :description
    column :created_at
    default_actions(:name => 'Configure Menu')
  end

  show :title => :name do
    render "show"
  end

  form :partial => "form"

  collection_action :sort, :method => :post do

    params[:sp] = [] if params[:sp].nil?

    params[:sp].each_with_index do |id, index|
      CmspageMenuSection.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end


  collection_action :menuremove, :method => :post do
    menu_section_id = params[:m_id]
    menu_section = MenuSection.find(menu_section_id)

    menu_id = params[:ms_id]
    menu_section.cmspage_menu_sections.destroy(menu_id)

    selected_ids = menu_section.cmspages.all(:select => 'cmspages.id').map(&:id)
    selected_ids = [0] if selected_ids.empty?
    @available_pages = Cmspage.active.all(:conditions => ['id not in (?)', selected_ids], :order => 'page_title asc')

    render :partial => "available"
  end

  collection_action :menuadd, :method => :post do
    menu_section_id = params[:m_id]
    menu_section = MenuSection.find(menu_section_id)

    page_or_link_id = params[:p_id];
    page_or_link = Cmspage.find(page_or_link_id)
    menu_section.cmspages << page_or_link

    render :partial => 'selected', :locals => { :resource => menu_section }
  end


end