require "test_helper"

describe "Coverage" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans a: 1, b: 7
  end

  it "coverage to_s" do
    res = order.act_with_booleans.to_s
    # puts res
    puts res if ENV["MORE"]
  end

  it "coverage position" do
    assert_equal 1, order.act_with_booleans.position(:a)
    assert_equal 7, Order.act_with_booleans.position(:b)
    assert_equal 7, order.act_with_booleans.position(:b)
    assert_raises { order.act_with_booleans.position(:unknown) }
  end

  it "coverage location raise" do
    assert_nil order.act_with_booleans.location(:unknown)
  end
end
