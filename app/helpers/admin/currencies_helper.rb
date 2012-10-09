module Admin::CurrenciesHelper
  def public_currency_path(currency)
    frontend_url("/#{currency.name.parameterize('_')}")
  end
  
  def currency_links_column(currency)
    html = link_to('Details', admin_currency_path(currency), :class => 'member_link')
    html << link_to('Edit', edit_admin_currency_path(currency), :class => 'member_link')
    html << link_to('Delete', admin_currency_path(currency),:method => :delete ,:class => 'member_link',:confirm => 'Are you sure?')
  end
  
end