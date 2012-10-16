class CreateDjPointsHistoryTable < ActiveRecord::Migration
  def change
    create_table :dj_point_histories do |t|
      t.references  :product
      t.integer     :points, :default => 0
      t.datetime    :date
    end
  end
end
