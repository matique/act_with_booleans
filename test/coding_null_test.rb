require "test_helper"

describe "Internal Null" do
  let(:admin) { Order.act_with_booleans }

  def setup
    reset_order
    Order.add_to_booleans
  end

  it "respond to act_with_booleans" do
    assert Order.respond_to?(:act_with_booleans)
    refute_nil Order.act_with_booleans
  end

  it "tests to_boolean" do
    assert admin.to_boolean(true)
    assert admin.to_boolean("true")
    assert admin.to_boolean(1)
    assert admin.to_boolean("1")
    refute admin.to_boolean(false)
    refute admin.to_boolean("false")
    refute admin.to_boolean(0)
    refute admin.to_boolean("0")
    assert_raises { admin.to_boolean(nil) }
    assert_raises { admin.to_boolean(2) }
    assert_raises { admin.to_boolean("unknown") }
  end
end
