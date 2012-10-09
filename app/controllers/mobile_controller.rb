class MobileController < ApplicationController
  layout 'mobile'

  def index
  end

  def cities
    @cities = City.unscoped.active.joins(:products).select('cities.id, cities.name, cities.slug, count(products.id) as num').where('products.published').group('cities.id').order('count(products.id) desc')

    respond_to do |f|
      f.html { render "mobile/cities" }
    end
  end

  def search
    @city = City.find(params[:city]) if params[:city]
    @search = searcher.new(params[:search])
    @search.city_id = @city.id if @city
    @search.per_page = 20
    @results = @search.results

    respond_to do |f|
      f.html { render "mobile/listings" }
    end
  end

  def show_info
    @resource = resource_class.published.find(params[:id])
    @product = @resource.product
    @owner = @resource.user

    respond_to do |f|
      f.html { render "mobile/show_info" }
    end
  end

  def show_map
    @resource = resource_class.published.find(params[:id])
    @product = @resource.product

    respond_to do |f|
      f.html { render "mobile/show_map" }
    end
  end

  def show_photos
    @resource = resource_class.published.find(params[:id])
    @product = @resource.product

    respond_to do |f|
      f.html { render "mobile/show_photos" }
    end
  end

  def inquire
    if params[:id].present?
      @resource = resource_class.published.find(params[:id])
      @product = @resource.product

      respond_to do |f|
        f.html { render "mobile/inquire" }
      end
    else
      render "mobile/inquire_success"
    end
  end

protected
  def searcher
    resource_class.searcher
  end
end
