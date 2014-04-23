class BookOrderMailer < ActionMailer::Base

  def send_order(book_order)
    @book_order = book_order

    mail(:to => 'jjs@avopep.ch', :subject => 'Commande de livre', :from => @book_order.email)
  end

end
