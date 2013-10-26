require 'test/unit'
require '../lib/checkout'
require '../lib/special_price'

class CheckOutTest < Test::Unit::TestCase

  def test_totals
    assert_equal(  0, getPrice(''))
    assert_equal( 50, getPrice('A'))
    assert_equal( 30, getPrice('B'))
    assert_equal( 80, getPrice('AB'))
    assert_equal(115, getPrice('CDBA'))

    assert_equal(100, getPrice('AA'))
    assert_equal(130, getPrice('AAA'))
    assert_equal(180, getPrice('AAAA'))
    assert_equal(230, getPrice('AAAAA'))
    assert_equal(260, getPrice('AAAAAA'))

    assert_equal(160, getPrice('AAAB'))
    assert_equal(175, getPrice('AAABB'))
    assert_equal(190, getPrice('AAABBD'))
    assert_equal(190, getPrice('DABABA'))
  end

  def test_incremental
    co = createCheckout()
    assert_equal(  0, co.total)

    co.scan('A');  assert_equal( 50, co.total)
    co.scan('B');  assert_equal( 80, co.total)
    co.scan('A');  assert_equal(130, co.total)
    co.scan('A');  assert_equal(160, co.total)
    co.scan('B');  assert_equal(175, co.total)
  end

  def getPrice(goods)
    co = createCheckout()
    goods.split(//).each { |item| co.scan(item.to_s) }
    co.total
  end

  def createCheckout
    CheckOut.new(prices, specialPrices)
  end

  def prices
    { "A" => 50, "B" => 30, "C" => 20, "D" => 15 }
  end

  def specialPrices
    [SpecialPrice.new('A', 3, 20),
     SpecialPrice.new('B', 2, 15)]
  end
end