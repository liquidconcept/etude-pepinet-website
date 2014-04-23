# encoding: utf-8

class BookOrdersController < ApplicationController
  def show
    @book_order = BookOrder.new
  end

  def create
    @book_order = BookOrder.new(params[:book_order])

    if @book_order.valid?
      BookOrderMailer.send_order(@book_order).deliver

      @book_order = nil
    end

    render action: :show
  end
end
