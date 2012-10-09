module Admin::UsersHelper
  def user_links_column(user)
    html = link_to('Details', admin_user_path(user), :class => 'member_link')
    html << link_to('Edit', edit_admin_user_path(user), :class => 'member_link')
  end

  def reminder_status(status)
    status ? "Yes" : "No"
  end
end