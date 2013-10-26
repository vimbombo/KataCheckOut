class CheckOut
  def initialize prices, specials
    @specials = specials
    @prices = prices
    @total = 0
  end

  def scan code
    return if code.empty?

    @total += @prices[code]
    @specials.each { |special| @total -= special.discount(code) }

    @total
  end

  def total
    @total
  end
end