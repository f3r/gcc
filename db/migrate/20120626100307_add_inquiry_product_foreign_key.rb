class AddInquiryProductForeignKey < ActiveRecord::Migration
  def change
    add_column :inquiries, :product_id, :integer
  end
end
