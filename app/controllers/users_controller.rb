class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render :layout => 'plain'
  end
end
