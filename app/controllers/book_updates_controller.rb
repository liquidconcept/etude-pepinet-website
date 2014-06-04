# encoding: utf-8

class BookUpdatesController < ApplicationController
  include LatinToInteger
  before_filter :protected_page

  def index
    @sort = (params[:sort] && params[:sort].to_sym) || :chapter
    @book_updates = BookUpdates.order('created_at').all

    if @sort == :chapter
     @book_updates.sort! {|a, b| latin_to_integer(a.chapter) <=> latin_to_integer(b.chapter)}
    end
  end
end
