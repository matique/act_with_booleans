require "test_helper"

describe "any? all? and none?" do
  let(:order) { Order.new }

  def setup
    reset_order
#    Order.add_to_booleans a: 1, b: 7, c: 3
    Order.add_to_booleans a: 1, c: 3, b: 7
  end

  it "checks any?" do
    order.a = true
    assert order.booleans_any?(:a, :b)
    order.a = false
    refute order.booleans_any?(:a, :b)
  end

  it "checks any? #2" do
    order.b = true
    assert order.booleans_any?(:a, :b)
    order.b = false
    refute order.booleans_any?(:a, :b)
  end

  it "checks all?" do
    order.a = order.b = true
    assert order.booleans_all?(:a, :b)
    order.a = false
    refute order.booleans_all?(:a, :b)
  end

  it "checks none? #2" do
    order.a = order.b = true
    refute order.booleans_none?(:a, :b)
    order.a = false
    refute order.booleans_none?(:a, :b)
    order.b = false
    assert order.booleans_none?(:a, :b)
  end
end
