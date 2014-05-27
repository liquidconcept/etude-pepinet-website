# encoding: utf-8

class BookUpdatesController < ApplicationController
  before_filter :protected_page

  def index
    @book_updates = BookUpdates.all
  end
end
