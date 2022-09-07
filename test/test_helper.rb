if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
  end
end

require "minitest/autorun"
require "minitest/benchmark"
require "act_with_booleans"

class Order
  include ActWithBooleans

  attr_accessor :booleans
end

def reset_order
  Order.act_with_booleans&.reset
end
