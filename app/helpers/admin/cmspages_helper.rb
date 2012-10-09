module Admin::CmspagesHelper
  
  def cmspage_links_column(cmspage)
    html = ""
    #html = link_to('View', admin_cmspage_path(cmspage), :class => 'member_link')
    html << link_to('Edit', edit_admin_cmspage_path(cmspage), :class => 'member_link')
    unless cmspage.mandatory?
      html << link_to('Delete', admin_cmspage_path(cmspage),:method => :delete ,:class => 'member_link',:confirm => 'Are you sure?')
    end
    html.html_safe
  end
  
end