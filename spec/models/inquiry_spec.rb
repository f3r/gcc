require 'spec_helper'

describe Inquiry do
  before(:each) do
    @user = create(:user)
    @currency = create(:currency, :currency_code =>'USD')
    @product = create(:published_product, :currency => @currency)
    Inquiry.any_instance.stub(:spam?).and_return(false)
    @emails = ActionMailer::Base.deliveries = []
  end

  context "Price/Length" do
    before(:each) do
      @inquiry = Inquiry.new
      @inquiry.check_in = Date.today
      @inquiry.product = @product
    end

    it "supports weeks" do
      @inquiry.length = ['1', 'weeks']
      @inquiry.length_stay.should == 1
      @inquiry.length_stay_type.should == 'weeks'
      @inquiry.check_out.should == 1.week.from_now.to_date
    end

    it "supports 'more' length_stay" do
      @inquiry.length = ['more', 'months']
      @inquiry.check_out.should be_nil
      @inquiry.length_stay.should == -1
      @inquiry.length_stay_type.should == 'months'
    end

    it "shows the length in words" do
      @inquiry.length = ['2', 'months']
      @inquiry.length_in_words.should == '2 months'

      @inquiry.length = ['1', 'weeks']
      @inquiry.length_in_words.should == '1 week'

      @inquiry.length = ['1', 'bla']
      @inquiry.length_in_words.should be_nil
    end
  end

  context "Submit" do
    it "creates and notifies" do
      expect {
        Inquiry.create_and_notify(@product, @user, inquiry_params)
      }.to change(Inquiry, :count).by(1)

      @emails.size.should == 2
      inquiry = Inquiry.last
      inquiry.user.should == @user
      inquiry.product.should == @product
      inquiry.length_stay.should == 2
      inquiry.length_stay_type.should == 'months'
    end

    it "creates or ammends a conversation" do
      expect {
        Inquiry.create_and_notify(@product, @user, inquiry_params)
      }.to change(Conversation, :count).by(1)

      expect {
        expect {
          Inquiry.create_and_notify(@product, @user, inquiry_params)
        }.to change(Message, :count).by(1)
      }.to_not change(Conversation, :count)
    end
  end

  context "#transaction" do
    before(:each) do
      @inquiry = create(:inquiry)
    end

    it "returns a new transaction for an inquiry" do
      transaction = @inquiry.transaction
      transaction.should_not be_nil
      transaction.user.should == @inquiry.user
      transaction.product.should == @inquiry.product
      transaction.check_in.should == @inquiry.check_in
      transaction.check_out.should == @inquiry.check_out
    end
  end

  def inquiry_params
    check_in = 1.month.from_now
    {
      :extra => {
        :name => 'Peter Griffin',
        :email => 'peter@quahog.com',
        :mobile => '+85 1234 5566'
      },
      :date_start => check_in.to_s,
      :length_stay => '2',
      :length_stay_type => 'months',
      :message => 'Pets allowed?'
    }
  end

end
