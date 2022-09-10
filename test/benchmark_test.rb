# For development purposes; do not waste your tine reading it!
# YAGNI

require "test_helper"
require "benchmark"
require "benchmark/ips"
# ENV["MORE"] = "true"

describe "Internal timings boolean" do
  let(:order) { Order.new }

  def setup
    reset_order
    Order.add_to_booleans :blocked
  end

  it "times ips" do
    return unless ENV["MORE"]

    Benchmark.ips do |x|
      x.report("assign true : ") { order.blocked = true }
      x.report("assign false: ") { order.blocked = false }
      x.report("assign \"false\": ") { order.blocked = "false" }
      x.report("x = order.blocked? ") { x = order.blocked? }
      x.report("x = order.blocked ") { x = order.blocked }

      x.compare!
    end
  end
end

describe "Internal timings mask" do
  let(:order) { Order.new }
  let(:admin) { Order.act_with_booleans }

  def setup
    reset_order
    Order.add_to_booleans a: 1, c: 3, b: 7
    # Order.add_to_booleans a: 1, c: 3, b: 60
    # Order.add_to_booleans a: 1, c: 3, b: 1000
  end

  it "times ips" do
    return unless ENV["MORE"]

    Benchmark.ips do |x|
      x.report("mask(:a, :b):  ") { Order.booleans_mask(:a, :b) }
      x.report("any?(:a, :b):  ") { order.booleans_any?(:a, :b) }
      x.report("all?(:a, :b):  ") { order.booleans_all?(:a, :b) }
      x.report("none?(:a, :b): ") { order.booleans_none?(:a, :b) }

      x.compare!
    end
  end
end

class BenchFoo < Minitest::Benchmark
  def bench_order_blocked
    return unless ENV["MORE"]

    n = 1_000_000
    n = 100_000
    n = 10_000
    Order.add_to_booleans :blocked2
    order = Order.new
    assert_performance_constant do |input|
      n.times do
        order.blocked2 = true
        order.blocked2 = !order.blocked2
      end
    end
  end
end
