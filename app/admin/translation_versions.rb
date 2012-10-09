ActiveAdmin.register TranslationVersion  do
  menu false
  actions :show
  
  controller do
     def show
       show! do |format|
         format.js do
           render :js => "Translation.load_version(#{resource.to_json})"
         end
       end
     end
  end
end