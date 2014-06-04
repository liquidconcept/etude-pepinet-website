class SessionsController < ApplicationController
  def create
    if params[:password] == 'pepinet4divorce'
      session[:logged] = true
      redirect_to book_updates_path
    else
      session[:logged] = false
      redirect_to book_orders_path
    end
  end
end
