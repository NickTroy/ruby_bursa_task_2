class PublishedBook < Book
  attr_accessor :price, :pages_quantity, :published_at

  def initialize author, title, price, pages_quantity, published_at
    @price = price
    @pages_quantity = pages_quantity
    @published_at = published_at
    super author, title
  end

  def age
  	Time.now.utc.year - @published_at - 1
  end

  def book_price
    book.price
  end

  def penalty_per_hour
    age_penalty = 0.00007 * age * price
    size_penalty = 0.000003 * pages_quantity * price
    price_penalty = 0.0005 * price
    
    age_penalty + size_penalty + price_penalty
  end
end
