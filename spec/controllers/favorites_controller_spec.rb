require 'spec_helper'

describe FavoritesController do
  before(:each) do
    SiteConfig.stub(:product_class).and_return(Property)
    @user = create(:user)
    login_as @user

    @place = create(:published_place)
  end

  it "creates a new favorite" do
    expect {
      post :create, :id => @place.id
    }.to change(Favorite, :count).by(1)
  end

  it "removes a favorite" do
    fav = create(:favorite, :user_id => @user.id, :favorable_id => @place.product.id, :favorable_type => 'Product')
    expect {
      delete :destroy, :id => @place.id, :product_id => @place.id
    }.to change(Favorite, :count).by(-1)
  end

  it "doesn't remove another user favorite" do
    fav = create(:favorite, :user_id => @user.id + 1)
    expect {
      delete :destroy , :id =>  @place.id, :product_id => @place.id
    }.to raise_error
  end
end
