class HomeController < ApplicationController
  def error_403
    @error = 403
    render 'error'
  end

  def error_404
    @error = 404
    render 'error'
  end

  def error_422
    @error = 422
    render 'error'
  end

  def error_500
    @error = 500
    render 'error'
  end
end
