class AddInquiryBudget < ActiveRecord::Migration
  def change
    add_column :inquiries, :budget, :integer
  end
end
