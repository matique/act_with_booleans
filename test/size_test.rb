require "test_helper"

describe "size" do
  let(:admin) { Order.act_with_booleans }

  def setup
    reset_order
    Order.add_to_booleans
  end

  it "checks empty booleans" do
    assert_equal 0, admin.size
  end

  it "checks one boolean" do
    Order.add_to_booleans :a
    assert_equal 1, admin.size
  end

  it "checks size using postion" do
    n = 123
    Order.add_to_booleans a: n
    assert_equal n + 1, admin.size
  end

  it "trying to overwrite" do
    Order.add_to_booleans :a
    assert_equal 1, admin.size
    assert_raises { Order.add_to_booleans b: 0 }
  end
end
