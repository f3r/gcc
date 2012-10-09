require 'spec_helper'

describe QuestionsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @agent = FactoryGirl.create(:user)
  end

  context "Guest" do
    before(:each) do
      login_as @user
    end

    it "posts a questions" do
      product = build_stubbed(:product)
      Product.stub(:find).and_return(product)

      mailer = double('Mailer', :deliver => true)
      UserMailer.should_receive(:new_question).and_return(mailer)
      Comment.any_instance.stub(:product).and_return(product)

      xhr :post, :create, :product_id => product.id, :comment => {
        :comment => 'Pets allowed?'
      }

      response.should be_success

      q = Comment.last
      q.product_id.should == product.id
    end
  end

  context "Agent" do
    before(:each) do
      @product = build_stubbed(:product, :user => @agent)
      Product.stub(:find).and_return(@product)

      login_as @agent
    end

    it "deletes a question" do
      q = Comment.create!(:user => @agent, :comment => 'Delete me', :product_id => @product.id)
      lambda {
        xhr :delete, :destroy, :product_id => @product.id, :id => q.id
      }.should change(Comment, :count).by(-1)
    end

    it "responds a question" do
      q = Comment.create!(:user => @agent, :comment => '1 + 1?', :product_id => @product.id)

      mailer = double('mailer', :deliver => true)
      UserMailer.should_receive(:new_question_reply).and_return(mailer)

      xhr :post, :reply_to_message, :product_id => @product.id, :question_id => q.id, :comment => {
        :comment => '2'
      }

      response.should be_success

      q2 = Comment.last
      q2.replying_to.should == q.id
    end
  end
end
