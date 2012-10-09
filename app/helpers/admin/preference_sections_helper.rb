module Admin::PreferenceSectionsHelper
  def preference_section_links_column(preference_section)
    html = link_to('Details', admin_preference_section_path(preference_section), :class => 'member_link')
    if preference_section.active
       html << link_to('Deactivate', deactivate_admin_preference_section_path(preference_section), :method => :put, :class => 'member_link')
    else
       html << link_to('Activate', activate_admin_preference_section_path(preference_section), :method => :put, :class => 'member_link')
    end
    html << link_to('Edit', edit_admin_preference_section_path(preference_section), :class => 'member_link')
  end

end