require "test_helper"

# class A used elsewhere => use AA
class AA
  include ActWithBooleans
end

# dito
class BB
  include ActWithBooleans
end

# dito
class CC
  include ActWithBooleans
end

describe "Testing origin" do
  it "checks default origin :booleans" do
    assert_raises { AA.act_with_booleans.origin }
    AA.add_to_booleans
    assert_equal :booleans, AA.act_with_booleans.origin
  end

  it "checks origin set to :origin" do
    BB.add_to_booleans origin: :origin
    assert_equal :origin, BB.act_with_booleans.origin
    assert_raises { BB.act_with_booleans origin: :origin2 }
  end

  it "rejects a second origin" do
    CC.add_to_booleans
    assert_equal :booleans, CC.act_with_booleans.origin
    assert_raises { CC.act_with_booleans origin: :origin2 }
  end
end
