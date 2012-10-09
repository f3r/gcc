  class ListingsController < PrivateController
  layout 'plain'
  before_filter :find_resource, :except => [:index, :new, :create]

  def index
    @collection = resource_class.manageable_by(current_user)
  end

  def new
    if resource_class.user_reached_limit?(current_user)
      flash[:notice] = t('products.user_reached_limit')
      redirect_to edit_listing_path(collection.first)
    end
    @resource = resource_class.new
    @resource.currency ||= Currency.default
  end

  def create
    @resource = resource_class.new(params[:listing])
    @resource.user = current_user
    @resource.currency ||= Currency.default

    if @resource.save
      redirect_to edit_listing_path(@resource)
    else
      render :action => :new
    end
  end

  def show
    @my_products = (@resource.user == current_user)
    @product = @resource.product

    render 'search/show'
  end

  def edit
    @wizard = Wizard.new(@resource, params[:s])
    if !@resource.published? && !flash[:notice] && !flash[:error]
      flash.now[:info] = "Your listing is not published. Complete the wizard and click on 'Publish'"
    end
  end

  def update
    @resource.attributes = params[:listing]
    @wizard = Wizard.new(@resource, params[:s])

    if @wizard.save
      response = {:stat => "ok", :place => @resource}
    else
      response = {:stat => "fail", :err => @resource.errors.full_messages}
    end

    if request.xhr?
      render :json => response, :layout => false
    else
      if @wizard.just_finished?
        flash[:notice] = t('products.messages.listing_published')
        redirect_to :action => :show
      else
        flash[:notice] = t('products.updated')
        redirect_to :action => :edit, :s => @wizard.next_step
      end
    end
  end

  def update_currency
    @resource.attributes = params[:listing]
    @resource.save
    render :json => {:currency_sign => @resource.currency.label}
  end

  def update_address
    @user = @resource.user
    @user.attributes = params[:user]

    if @user.save
      flash[:notice] = 'You successfully updated your address'
      redirect_to edit_listing_path(@resource)
    else
      render :action => :edit
    end
  end

  def destroy
    if @resource.destroy
      flash[:notice] = t("products.messages.listing_deleted")
    else
      flash[:error] = t("products.messages.listing_deletion_error")
    end
    redirect_to listings_path
  end

  def publish
    if @resource.publish!
      flash[:success] = t("products.messages.listing_published")
      redirect_to listing_path(@resource)
    else
      flash[:error] = t("places.messages.place_publish_error")
      redirect_to edit_listing_path(@resource)
    end

  end

  def publish_check
    response = {:stat => "ok"}
    render :json => response, :layout => false
  end

  def unpublish
    @resource.unpublish!
    #flash[:notice] = t("products.messages.listing_unpublished")
    redirect_to edit_listing_path(@resource)
  end

  protected

  def find_resource
    @resource = collection.find(params[:id])
    @product = @resource.product
    @owner = @resource.user
  end

  def collection
    resource_class.manageable_by(current_user)
  end
end
