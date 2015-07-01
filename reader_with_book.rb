class ReaderWithBook < Reader
  attr_accessor :book, :current_page

  def initialize  name, reading_speed, book, current_page
    @book = book
    @current_page = current_page
    super  name, reading_speed
  end 

  def time_to_finish
  	(@book.pages_quantity - @current_page) / @reading_speed.to_f
  end
  
  def book_age
    book.age
  end

  def book_price
    book.price
  end

  def book_penalty_per_hour
    book.penalty_per_hour
  end

  def penalty hours
    (@book.penalty_per_hour * hours).round
  end


end
