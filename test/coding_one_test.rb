require "test_helper"

describe "Internal One Flag" do
  let(:bool) { :blocked }
  let(:admin) { Order.act_with_booleans }
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans bool
  end

  it "test order.act_with_" do
    refute_nil admin
    assert_equal admin, order.class.act_with_booleans
    assert_equal admin, order.act_with_booleans
    assert_equal admin, Order.act_with_booleans
  end

  it "checks definition of methods" do
    msg = "method '#{bool}' not defined"
    assert order.respond_to?(bool.to_s), msg
    assert order.respond_to?("#{bool}?"), msg
    assert order.respond_to?("#{bool}="), msg
  end
end
