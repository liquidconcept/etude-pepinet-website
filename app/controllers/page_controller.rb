class PageController < ApplicationController
  def show
    @page = params[:page] || 'home'

    if @page
      render :template => "page/#{@page}"
    else
      # TODO: render not found page
      render text: '404', status: 404
    end
  end
end
