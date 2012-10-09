module Admin::TransactionsHelper
  def transaction_links_column(transaction)
    html = link_to('View', admin_transaction_path(transaction))
  end
  
end