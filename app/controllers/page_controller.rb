class PageController < ApplicationController
  def show
    # TODO: check if template exist
    if current_static_page
      render template: "page/#{current_static_page}"
    else
      # TODO: render not found page
      render text: '404', status: 404
    end
  end

  private

  def current_static_page
    @page = (controller_name == 'page' ? (params[:page] || 'home') : nil)
  end
end
