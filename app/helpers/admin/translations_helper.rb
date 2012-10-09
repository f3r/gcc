module Admin::TranslationsHelper
  def translatable_entities
    [['User Role', 'users.role_user'],
    ['User Role (Plural)', 'users.role_user_plural'],
    ['Agent Role', 'users.role_agent'],
    ['Agent Role (Plural)', 'users.role_agent_plural']]
  end

  def translatable_workflow
    [:initial_guest, :initial_guest_button, :initial_agent, :requested_guest, :requested_agent, :requested_agent_button, :reject_offer_agent_button,
     :readypay_guest, :readypay_guest_button, :readypay_agent, :paid_guest, :paid_agent, :system_msg_send, :system_msg_request,
     :system_msg_pre_approve,:system_msg_decline, :system_msg_pay, :error_in_transaction].collect{|k| "workflow.#{k}"}
  end

  def translatable_verbs
    []
  end

  def translation_edit(label, key)
    t = Translation.find_by_key(key)
    html = label_tag('User role')
    html << I18n.t(key)
    if t
      html << link_to('Edit', edit_admin_translation_path(t))
    else
      html << link_to('Edit', new_admin_translation_path(:key => key))
    end
    html.html_safe
  end

  def translation_value_with_links(translation,locale)
    if locale == translation.locale
      html = CGI::escapeHTML(translation.value)
      html << "<br />"
      html << link_to('Edit', edit_admin_translation_path(translation), :class => 'member_link')
      html << link_to('Delete', admin_translation_path(translation),:method => :delete ,:class => 'member_link',:confirm => 'Are you sure?')
    else
      other = translation.other_language(locale)
      if other
        html = CGI::escapeHTML(other.value)
        html << "<br />"
        html << link_to('Edit', edit_admin_translation_path(other), :class => 'member_link')
        html << link_to('Delete', admin_translation_path(other),:method => :delete ,:class => 'member_link',:confirm => 'Are you sure?')
      else
        html = link_to "Create translation", new_admin_translation_path(:locale => locale, :key => translation.key)
      end
    end
    raw html
  end

end