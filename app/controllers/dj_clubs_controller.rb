class DjClubsController < ApplicationController
  layout 'plain'

  def list
    @clubs = DjClub.with_points
  end

end
