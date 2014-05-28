# encoding: utf-8

class BookUpdatesController < ApplicationController
  include LatinToInteger
  before_filter :protected_page

  def index
    @book_updates = BookUpdates.all.sort {|a, b| latin_to_integer(a.chapter) <=> latin_to_integer(b.chapter)}
  end
end
