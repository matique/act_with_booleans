require "test_helper"

class A
  include ActWithBooleans
end

class B
  include ActWithBooleans
end

class C
  include ActWithBooleans
end

describe "Testing origin" do
  it "checks default origin :booleans" do
    assert_raises() { A.act_with_booleans.origin }
    A.add_to_booleans
    assert_equal :booleans, A.act_with_booleans.origin
  end

  it "checks origin set to :origin" do
    B.add_to_booleans origin: :origin
    assert_equal :origin, B.act_with_booleans.origin
    assert_raises() { B.act_with_booleans origin: :origin2 }
  end

  it "rejects a second origin" do
    C.add_to_booleans
    assert_equal :booleans, C.act_with_booleans.origin
    assert_raises() { C.act_with_booleans origin: :origin2 }
  end
end
