require "test_helper"

describe "Order: just include ActWithBooleans and :booleans" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans
  end

  it "respond to ActWithBooleans API" do
    assert Order.respond_to?(:add_to_booleans)
    assert Order.respond_to?(:act_with_booleans)
    assert Order.respond_to?(:booleans_mask)
  end

  it "checks mask et all; no parameters" do
    assert_equal 0, order.booleans_mask
    refute order.booleans_any?
    assert order.booleans_all?
    assert order.booleans_none?
  end
end
