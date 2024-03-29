require "test_helper"

describe "One Flag" do
  let(:bool) { :blocked }
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans bool
  end

  it "checks defaults" do
    refute_equal true, order.blocked
    assert_equal false, order.blocked
    assert_equal false, order.blocked?
  end

  it "set :blocked" do
    order.blocked = true
    assert_equal true, order.blocked
    assert_equal true, order.blocked?

    order.blocked = "false"
    assert_equal false, order.blocked
    assert_equal false, order.blocked?
  end

  it "rejects redefining" do
    assert_raises { Order.add_to_booleans bool }
  end

  it "rejects redefining #2" do
    Order.add_to_booleans :berta
    assert_raises { Order.add_to_booleans :berta }
  end
end
