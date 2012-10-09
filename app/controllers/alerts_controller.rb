class AlertsController < PrivateController
  layout 'plain'
  
  def index
    @alerts = current_user.alerts
  end

  def edit
    @alert = current_user.alerts.find(params[:id])
    respond_to do |format|
      format.html
      format.js {
        render :layout => false
      }
    end
  end

  def create
    search_params = params[:alert].delete(:search_attributes)
    @search = resource_class.searcher.new(search_params)
    @alert = current_user.alerts.new(params[:alert])
    @alert.search = @search
    
    if @alert.save
      flash[:success] = t("alerts.message_alert_created")
    else
      flash[:error] = t("alerts.error_alert")
    end
    redirect_to alerts_path
  end

  def update
    params[:alert][:search_attributes][:category_ids] = params[:alert][:search_attributes][:category_ids] || []
    params[:alert][:search_attributes][:amenity_ids]  = params[:alert][:search_attributes][:amenity_ids]  || []

    @alert = current_user.alerts.find(params[:id])
    if @alert.update_attributes(params[:alert])
      flash[:success] = t("alerts.message_alert_updated")
    else
      flash[:error] = t("alerts.error_alert")
    end
    redirect_to alerts_path
  end

  def destroy
    @alert = current_user.alerts.find(params[:id])
    if @alert.soft_delete
      flash[:success] = t("alerts.message_alert_deleted")
    else
      flash[:error] = t("alerts.error_alert")
    end
    redirect_to alerts_path
  end

  def pause
    @alert = current_user.alerts.find(params[:id])
    @alert.active = false
    if @alert.save
      flash[:success] = t("alerts.message_alert_paused")
    else
      flash[:error] = t("alerts.error_alert")
    end
    redirect_to alerts_path
  end

  def unpause
    @alert = current_user.alerts.find(params[:id])
    @alert.active = true
    if @alert.save
      flash[:success] = t("alerts.message_alert_unpaused")
    else
      flash[:error] = t("alerts.error_alert")
    end
    redirect_to alerts_path
  end

end