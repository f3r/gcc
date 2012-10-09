require 'spec_helper'

describe InquiriesController do
  before(:each) do
    @product = create(:published_product)
    SiteConfig.stub(:product_class).and_return(Property)
  end
  context "Create" do
    it "sends an inquiry for a registered user" do
      @user = create(:user)
      login_as @user

      Inquiry.any_instance.stub(:spam?).and_return(false)
      expect {
        xhr :post, :create, inquiry_params.merge(:product_id => @product.id)
      }.should change(Inquiry, :count).by(1)
    end

    it "sends an inquiry and creates a new user" do
      Inquiry.any_instance.stub(:spam?).and_return(false)
      expect {
        xhr :post, :create, inquiry_params.merge(:product_id => @product.id, :name => 'michelle', :email => 'michelle@mail.com')
      }.should change(Inquiry, :count).by(1)

      user = User.last
      user.full_name.should == 'michelle'
      user.email.should == 'michelle@mail.com'
    end
  end

  context "Edit" do
    before(:each) do
      @user = create(:user)
      login_as @user
      @inquiry = create(:inquiry, :user => @user)
    end

    it "edits an inquiry" do
      xhr :get, :edit, :id => @inquiry.id
      response.should be_success
    end

    it "updates an inquiry" do
      xhr :put, :update, :id => @inquiry.id, :inquiry => {:check_in => 1.week.from_now.to_s}, :conversation_id => 1
      response.should be_redirect
      @inquiry.reload
      @inquiry.check_in.should == 1.week.from_now.to_date
    end
  end

  def inquiry_params(params = {})
    {
      :inquiry => {
        :date_start => 1.month.from_now.to_s,
        :length_stay => '2',
        :length_stay_type => 'months',
        :message => 'Looks like a great place for partying',
      }.merge(params)
    }
  end
end
