# frozen_string_literal: true

# Principles:
#  POLA
#  KISS
#  YAGNI
#  POLS
#  DEI
#  TDD
#  TGCB
#  TIOLI
#  PORO

module ActWithBooleans
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_reader :act_with_booleans

    def add_to_booleans(*flags, origin: nil, **hash)
      origin = origin&.to_sym
      init(origin)

      flags.each { |name| @act_with_booleans.add_flag(name, nil) }
      hash.each { |name, pos| @act_with_booleans.add_flag(name, pos) }
    end

    def remove_from_flags(*flags)
      flags.each { |name| @act_with_booleans.remove_accessor(name) }
    end

    private

    def init(origin)
      unless @act_with_booleans
        @act_with_booleans = ActWithBooleans::Admin.new self
        @act_with_booleans.origin = origin || :booleans
        origin = nil
        @act_with_booleans.add_mask_et_all origin
      end
      raise "ActWithBooleans: origin already defined" if origin
    end
  end
end

#  module Base
# ...
#
#    def remove_from_flags(*flags)
#      flags.each { |name| @act_with_booleans.remove_accessor(name) }
#    end
#
#    def clear_flags_at_save(*flags)
#      @act_with_booleans.clear_at_save(*flags)
#    end
# ...
#
#      rng = @act_with_booleans.ranges[origin]
#      unless range.nil? || (range == rng)
#        msg = "incompatible ranges #{range} - #{rng}"
#        raise ArgumentError, msg unless rng.nil?
#        @act_with_booleans.ranges[origin] = range if range
#        validate_previous_positions(origin, range)
#      end
#    end
#
#    def validate_previous_positions(origin, range)
#      return if range.nil?
#
#      @act_with_booleans.locations.each do |name, location|
#        next unless location.origin == origin
#
#        @act_with_booleans.validate_position(range, location.position)
#      end
#    end
#
#    def validate_range_value(range_value)
#      return if range_value.nil?
#      return if range_value.is_a?(Integer) && range_value >= 0
#
#      raise RangeError, "Invalid range value #{range_value}"
#    end
#  end
# end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require "act_with_booleans/version"
require "act_with_booleans/utils"
require "act_with_booleans/define"
require "act_with_booleans/admin"
require "act_with_booleans/flags"
require "act_with_booleans/clear"
require "act_with_booleans/print"
