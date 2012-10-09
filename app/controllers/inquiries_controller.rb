class InquiriesController < ApplicationController
  respond_to :js, :html

  before_filter :find_product, :only => [:new, :create]

  def new
    respond_to do |format|
      format.js { render :layout => false, :template => "inquiries/new" }
    end
  end

  def create
    @user = current_user

    # If the user is not logged in, we signed them up
    unless @user
      @user = User.auto_signup(params[:name], params[:email])
      if @user.persisted?
        sign_in @user
      end
      @just_created = true
    end

    if @user.persisted?
      @inquiry = Inquiry.create_and_notify(@product, @user, params[:inquiry])
    end

    # Quick hack to get status from mobile version
    # TODO: Fix with MIME types
    if params[:mobile].present?
      redirect_to mobile_inquire_path
    else
      respond_to do |format|
        format.js { render :layout => false, :template => "inquiries/create" }
      end
    end
  end

  def edit
    @inquiry = current_user.inquiries.find(params[:id])
    respond_to do |format|
      format.js { render :layout => false, :template => "inquiries/edit" }
    end
  end

  def update
    @inquiry = current_user.inquiries.find(params[:id])
    @inquiry.update_attributes(params[:inquiry])
    redirect_to message_path(:id => params[:conversation_id])
  end

  protected

  def find_product
    @product = Product.find(params[:product_id])
  end
end