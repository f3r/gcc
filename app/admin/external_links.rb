ActiveAdmin.register ExternalLink  do
  menu false
  
  controller do
    actions :new, :create
    
   def new
     unless params[:frommenu].nil?
       session[:frommenu] = params[:frommenu]
     end
     new!
   end 
   
   def create
    create! do |format|
        frommenu = session[:frommenu]
        format.html do
            if frommenu.nil? 
              redirect_to admin_cmspages_path
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
    
  end
  
  form do |f|
    f.inputs do
      f.input :page_title
      f.input :page_url , :label => "Page Url", :hint => "This link will be opened in new window in the front-end"
      f.input :active
    end
    f.buttons
  end
  
end