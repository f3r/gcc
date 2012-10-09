class HomeController < ApplicationController
  skip_before_filter :log_request, :only => :alive

  def index
    @body_id = 'home_page'
  end

  def robot
    render :layout => false, :content_type => "text/plain"
  end

  def set_ref
    respond_to do |format|
      session[:user_return_to] = params[:ref] if params[:ref] && !params[:ref].blank?
      format.json { render :inline => "ok" }
    end
  end

  def staticpage
    @staticpage = Cmspage.find_by_url(params[:pages])
    raise ActiveRecord::RecordNotFound unless @staticpage
    @body_id = "#{@staticpage.page_url}_page"
  end

  def photo_faq
    render :template => 'home/photo_faq'
  end

  def alive
    head :ok
  end
end