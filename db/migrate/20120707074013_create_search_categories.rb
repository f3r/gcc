class CreateSearchCategories < ActiveRecord::Migration
  def change
    create_table :search_categories do |t|
      t.references :search
      t.references :category
    end
  end
end