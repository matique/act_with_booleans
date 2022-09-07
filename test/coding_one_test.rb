require "test_helper"

describe "Internal One Flag" do
  let(:flag) { :blocked }
  let(:admin) { Order.act_with_booleans }
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans flag
  end

  it "test order.act_with_booleans" do
    refute_nil admin
    assert_equal admin, order.class.act_with_booleans
    assert_equal admin, order.act_with_booleans
    assert_equal admin, Order.act_with_booleans
  end

  it "checks definition of methods for flag" do
    msg = "method '#{flag}' not defined"
    assert order.respond_to?(flag.to_s), msg
    assert order.respond_to?("#{flag}?"), msg
    assert order.respond_to?("#{flag}="), msg
  end
end
