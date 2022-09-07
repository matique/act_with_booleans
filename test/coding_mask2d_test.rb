require "test_helper"

# There is an interference with Class B in another test: call it BB!
class BB < Order
  add_to_booleans x: 1
end

describe "mask2d" do
  let(:admin) { BB.act_with_booleans }

  def setup
    reset_order
    Order.add_to_booleans y: 2
  end

  it "is a non splitted mask" do
    mask = admin.mask2d(:x)
    assert_equal 1, mask.length
  end

  it "is a splitted mask" do
    mask = admin.mask2d(:x, :y)
    assert_equal 2, mask.length
  end
end
