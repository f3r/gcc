class AddProductWizardStep < ActiveRecord::Migration
  def change
    add_column :products, :completed_steps, :integer, :default => 0
  end
end
