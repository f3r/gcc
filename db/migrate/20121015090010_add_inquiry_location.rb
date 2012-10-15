class AddInquiryLocation < ActiveRecord::Migration
  def change
    add_column :inquiries, :location, :string
  end
end
