# Override the translation method so that it always includes some default replacement variables
def options_with_replacements(options)
  options.merge({
    :site_name => SiteConfig.site_name,
    :site_url => SiteConfig.site_url,
    :site_tagline => SiteConfig.site_tagline,
    :support_email => SiteConfig.support_email,
    :support_email_link => "<a href='mailto:#{SiteConfig.support_email}'>#{SiteConfig.support_email}</a>".html_safe,
    :product_name => SiteConfig.product_name,
    :product_plural => SiteConfig.product_plural,
    :role_agent => I18n.t('users.role_agent'),
    :role_agent_lower => I18n.t('users.role_agent').downcase,
    :role_agent_plural => I18n.t('users.role_agent_plural'),
    :role_agent_plural_lower => I18n.t('users.role_agent_plural').downcase,
    :role_user => I18n.t('users.role_user'),
    :role_user_lower => I18n.t('users.role_user').downcase,
    :role_user_plural => I18n.t('users.role_user_plural'),
    :role_user_plural_lower => I18n.t('users.role_user_plural').downcase
  })
end

module ActionView::Helpers::TranslationHelper
  def translate_with_replacements(key, options={})
    translate_without_replacements(key, options_with_replacements(options))
  end

  alias_method_chain :translate, :replacements
  alias :t :translate
end

module AbstractController
  module Translation
    def translate_with_replacements(key, options={})
      translate_without_replacements(key, options_with_replacements(options))
    end

    alias_method_chain :translate, :replacements
    alias :t :translate
  end
end