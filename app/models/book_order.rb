# encoding: utf-8

class BookOrder
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :email, :phone, :name, :address, :zip, :city, :quantity, :mail_sent

  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :allow_blank => true, :message => 'Le champ email n\'est pas valide'
  validates_presence_of :email, :message => 'Le champ email ne peut pas être vide'
  validates_numericality_of :quantity, :only_integer => true
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :zip

  def initialize(params = {})
    @email = params[:email]
    @phone = params[:phone]
    @name = params[:name]
    @address = params[:address]
    @zip = params[:zip]
    @city = params[:city]
    @quantity = params[:quantity]

    @mail_sent = false
  end
end
