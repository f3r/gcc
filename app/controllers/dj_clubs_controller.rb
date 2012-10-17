class DjClubsController < ApplicationController
  layout 'plain'

  def list
    if params.delete :global
      @global = true
      @clubs = DjClub.with_points
      return
    end

    @city = City.find(params[:city]) if params[:city]
    @clubs = DjClub.with_points @city
  end

  def show
    @club = DjClub.find(params[:id])
  end

end
