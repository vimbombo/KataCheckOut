class SpecialPrice
  def initialize required_code, required_number, discount
    @required_code = required_code
    @required_number = required_number
    @discount = discount
    @count = 0
  end

  def discount code
    @count += 1 if code == @required_code

    if @count==@required_number
      @count = 0

      return @discount
    end

    0
  end
end