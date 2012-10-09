class AdminDashboard

  def self.user_funnel
    stats = {}
    stats[:user_count] = {:label => "Registered Users", :value => User.consumer.count}
    stats[:user_active_count] = {:label => "Users active in last 30 days", :value => User.consumer.where('last_sign_in_at >= ?', Time.now - 30.days).count}
    stats
  end

  def self.transaction_funnel
    stats = {}
    stats[:inquiry_count] = {:label => "Inquiries", :value => Inquiry.count, :bar_color => "DB3026"}
    stats[:transaction_initial_state] = {:label => "Transaction Stage - Initial", :value => Transaction.where(:state => 'initial').count, :bar_color => "E88A25"}
    stats[:transaction_requested_state] = {:label => "Transaction Stage - Requested", :value => Transaction.where(:state => 'requested').count, :bar_color => "F9E14B"}
    stats[:transaction_ready_to_pay_state] = {:label => "Transaction Stage - Ready to Pay", :value => Transaction.where(:state => 'ready_to_pay').count, :bar_color => "EFED89"}
    stats[:transaction_paid_state] = {:label => "Transaction Stage - Paid", :value => Transaction.where(:state => 'paid').count, :bar_color => "7ABF66"}
    stats[:transaction_declined_state] = {:label => "Transaction Stage - Declined", :value => Transaction.where(:state => 'declined').count, :bar_color => "AD400A"}
    stats
  end


  def self.agent_funnel
    stats = {}
    stats[:agent] = {:label => "Agents", :value => User.agent.count}
    stats[:agent_with_listing] = {:label => "Own listing", :value => Product.count(:user_id, :distinct => true)}
    stats[:agent_with_published_listing] = {:label => "Published listing", :value => Product.published.count(:user_id, :distinct => true)}
    stats
  end
end