class SessionsController < ApplicationController
  def create
    if params[:password] == '123456'
      session[:logged] = true
      redirect_to book_updates_path
    else
      session[:logged] = false
      redirect_to book_orders_path
    end
  end
end
