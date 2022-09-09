require "test_helper"

class A < Order
end

class B < Order
  include ActWithBooleans

  add_to_booleans y: 2
end

describe "inheritance" do
  let(:order) { Order.new }
  let(:a) { A.new }
  let(:b) { B.new }

  def setup
    reset_order
    Order.add_to_booleans x: 1
  end

  it "tests Order" do
    refute order.x?
    order.x = true
    assert order.x?
  end

  it "tests A" do
    refute a.x?
    a.x = true
    assert a.x?
  end

  it "tests B" do
    refute b.x?
    b.x = true
    assert b.x?

    refute b.y?
    b.y = true
    assert b.y?

    assert_raises { order.y? }
  end

  it "tests booleans_mask" do
    assert_equal 0x02, Order.booleans_mask(:x)
    assert_raises { Order.booleans_mask(:y) }
    assert_equal 0x02, B.booleans_mask(:x)
#    assert_raises { B.booleans_mask(:x) }
    assert_equal 0x04, B.booleans_mask(:y)

    assert_equal 0x02, B.booleans_mask(:x, :y)
  end
end
