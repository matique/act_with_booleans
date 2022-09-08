require "test_helper"

describe "Coverage" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans a: 1, b: 7
  end

  it "coverage to_s" do
    res = order.act_with_booleans.to_s
    puts res if ENV["MORE"]
  end

  it "coverage location raise" do
    assert_raises { order.act_with_booleans.location(:unknown) }
  end
end
