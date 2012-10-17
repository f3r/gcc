class AddRankToDjPointHistory < ActiveRecord::Migration
  def change
     add_column :dj_point_histories, :rank, :integer
  end
end
