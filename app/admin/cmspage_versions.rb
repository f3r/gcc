ActiveAdmin.register CmspageVersion  do
  menu false
  actions :show

  controller do
    def show
      show! do |format|
        format.js do
          render :js => "Cmspage.load_page_version_to_editor(#{resource.to_json})"
        end
      end
    end
  end
end