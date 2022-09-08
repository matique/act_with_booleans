require "test_helper"

describe "Testing reset" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans :a
  end

  it "reset hard" do
    empty = {}
    refute_equal empty, Order.act_with_booleans.locations

    Order.act_with_booleans&.reset
    assert_equal empty, Order.act_with_booleans.locations
  end
end
