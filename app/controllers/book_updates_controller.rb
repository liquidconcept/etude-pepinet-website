# encoding: utf-8

class BookUpdatesController < ApplicationController
  def index
    @book_updates = BookUpdates.all
  end
end
