require "test_helper"

describe "No Flags" do
  def setup
    reset_order
    Order.add_to_booleans
  end

  it "respond to ActWithBooleans API" do
    assert Order.respond_to?(:add_to_booleans)
    assert Order.respond_to?(:act_with_booleans)
    assert Order.respond_to?(:booleans_mask)
  end
end
