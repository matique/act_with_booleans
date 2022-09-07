require "test_helper"

describe "Internal check add flag" do
  let(:order) { Order.create }

  def setup
    reset_order
    Order.add_to_booleans a: 1, b: 7
  end

  it "skip reserved position" do
    Order.add_to_booleans :xx
    order.xx = true
    assert_equal 0x100, order.flags

    Order.add_to_booleans :yy
    order.yy = true
    assert_equal 0x300, order.flags
  end

  it "rejects redefinition" do
    Order.add_to_booleans :z
    assert_raises { Order.add_to_booleans :z }
  end

  it "rejects reuse of position" do
    assert_raises { Order.add_to_booleans qq: 1 }
  end
end