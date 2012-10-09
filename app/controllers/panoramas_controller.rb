class PanoramasController < PrivateController
  layout 'plain'
  before_filter :find_parent, :except => [:new]

  def new
    respond_to do |format|
      format.js{ render :template => 'panoramas/new.js.erb', :layout => false }
    end
  end

  def create
    panorama_params = params[:panorama]

    if panorama_params && panorama_params[:xml].respond_to?(:read)
      panorama_params[:xml] = panorama_params[:xml].read
    end

    @panorama = @product.panoramas.create(panorama_params)
    redirect_to edit_listing_path(@resource, :anchor => 'panoramas-tab')
  end

  def destroy
    @panorama = @product.panoramas.find(params[:id])
    @panorama.destroy
    
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  protected

  def find_parent
    @resource = resource_class.manageable_by(current_user).find(params[:listing_id])
    @product = @resource.product    
  end
end
