require 'spec_helper'

describe Favorite do
  before(:each) do
    @user  = build_stubbed(:user)
    @place = create(:property)

    @favorite = Favorite.create!(
      :user => @user,
      :favorable => @place.product
    )
  end

  it "stores a user favorite" do
    @favorite.should be_persisted
    @favorite.reload
    @favorite.favorable_type.should == 'Product'
    # @favorite.product.should == @place.product
  end

  it "retrieves user favorites" do
    favs = Favorite.for_user(@user, Property)
    favs.size.should == 1

    favs[0].should == @place
  end

  it "checks if an object is favorited" do
    Favorite.is_favorited?(@place, @user).should be_true
    @user2 = build_stubbed(:user)
    Favorite.is_favorited?(@place, @user2).should be_false
  end
end
