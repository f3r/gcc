require 'spec_helper'

describe PanoramasController do
  before(:each) do
    @agent   = create(:agent)
    login_as @agent
    @place   = create(:property, :user => @agent)
    @product = @place.product
    SiteConfig.stub(:product_class).and_return(Property)

    (0..5).each do |i|
      Panorama.attachment_definitions["asset_#{i}".to_sym][:path] = "public/system/:class/:id/images/:filename"
    end
    Panorama.attachment_definitions[:html][:path] = "public/system/panoramas/:id/embed.html"
  end

  it "creates a panorama" do
    expect {
      post :create, { :listing_id => @place.id, :panorama => {
        :xml => '<xml/>',
        :asset_0 => fixture_file_upload('spec/files/prop.jpg'),
        :asset_1 => fixture_file_upload('spec/files/prop.jpg'),
        :asset_2 => fixture_file_upload('spec/files/prop.jpg'),
        :asset_3 => fixture_file_upload('spec/files/prop.jpg'),
        :asset_4 => fixture_file_upload('spec/files/prop.jpg'),
        :asset_5 => fixture_file_upload('spec/files/prop.jpg')
      }}
    }.to change(Panorama, :count).by(1)
  end

end
