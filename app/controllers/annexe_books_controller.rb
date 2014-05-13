# encoding: utf-8

class AnnexeBooksController < ApplicationController
  def index
    @annexe = AnnexeBooks.all
  end
end
