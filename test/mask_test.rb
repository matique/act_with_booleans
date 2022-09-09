require "test_helper"

describe "mask" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans a: 1, c: 3, b: 7
  end

  it "mask empty" do
    assert_equal 0x00, order.booleans_mask
  end

  it "mask of one boolean" do
    assert_equal 0x80, order.booleans_mask(:b)
  end

  it "mask of several booleans" do
    assert_equal 0x8a, order.booleans_mask(:a, :b, :c)
  end

  it "order is not relevant" do
    mask = order.booleans_mask(:a, :b, :c)
    assert_equal mask, order.booleans_mask(:c, :b, :a)
  end
end
