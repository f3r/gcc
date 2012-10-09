class ErrorsController < ApplicationController
  layout 'error'

  def page_not_found
    render 'page_not_found', :status => 404
  end

  def exception
    render 'exception', :status => 500
  end
end
