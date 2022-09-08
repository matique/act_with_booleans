require "test_helper"

describe "Testing origin" do
  let(:admin) { Order.act_with_booleans }
  let(:order) { Order.new }

  def setup
    reset_order
  end

  it "location origin1" do
    Order.add_to_booleans :x, origin: :origin1
    assert_equal :origin1, admin.location(:x).origin
  end

  it "origin default" do
    Order.add_to_booleans :x
    assert_equal :booleans, admin.location(:x).origin
  end
end
