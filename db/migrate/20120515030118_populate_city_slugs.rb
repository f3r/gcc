class PopulateCitySlugs < ActiveRecord::Migration
  def up
    City.find_each(&:save)
  end

  def down
  end
end
