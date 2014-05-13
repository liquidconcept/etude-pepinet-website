# encoding: utf-8

class AnnexeBooksController < ApplicationController
  def index
    @annexes = AnnexeBooks.all
  end
end
