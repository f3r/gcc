class AvailabilitiesController < ApplicationController
  before_filter :login_required

  def create
    param = {}
    %w(availability_type date_start date_end price_per_night).each do |p|
      param[p.to_sym] = params[p]
    end
    param[:access_token] = current_token
    param[:place_id] = params[:place_id]

    availability = Heypal::Availability.new(param)
    saved, result = availability.save

    if saved
      place = Heypal::Place.find(result['place_id'].to_s, current_token)
      availabilities = Heypal::Availability.find_all({:place_id => place.to_param}, current_token)

      render :json => {:stat => true, :data => render_to_string(:_list_all, :locals => {:availabilities => availabilities, :place => place}, :layout => false)}

      # TODO: returns all for now, cause I can't insert it in the middle of the availabilities list.
      #render :json => {:stat => true, :data => render_to_string(:_list, :locals => {:a => availability, :place => place}, :layout => false)}
    else
      render :json => {:stat => false, :data => error_codes_to_messages(result).join(', ')}
    end
  end

  def update
    param = {}
    %w(availability_type date_start date_end price_per_night).each do |p|
      param[p.to_sym] = params[p]
    end
    param[:access_token] = current_token
    param[:place_id] = params[:place_id]
    param[:id] = params[:id]
    saved, result = Heypal::Availability.update(param)

    if saved
      place = Heypal::Place.find(result['place_id'].to_s, current_token)

      render :json => {:stat => true, :data => render_to_string(:_list, :locals => {:a => result, :place => place}, :layout => false)}
    else
      render :json => {:stat => false, :data => error_codes_to_messages(result).join(', ')}
    end
  end

  def destroy
    param = {}
    param[:access_token] = current_token
    param[:place_id] = params[:place_id]

    if Heypal::Availability.delete(params[:id], param)
      render :json => {:stat => true}
    else
      render :json => {:stat => false, :data => t("places.availabilities.messages.something_went_wrong")}
    end
  end
end
