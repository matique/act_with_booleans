# frozen_string_literal: true

# Principles:
#  POLA
#  KISS
#  YAGNI
#  POLS
#  DEI
#  TDD
#  TGCB

module ActWithBooleans
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_reader :act_with_booleans

    def add_to_booleans(*flags, origin: :booleans, **hash)
p 111111111111
    end
  end
end

#  module Base
#    attr_reader :act_with_booleans
#
#    def add_to_booleans(*flags, origin: :flags, range: nil, **hash)
#      origin = origin.to_sym
#      init(origin, range)
#
#      flags.each { |name| @act_with_booleans.add_flag(name, nil, origin) }
#      hash.each { |name, pos| @act_with_booleans.add_flag(name, pos, origin) }
#
#      @act_with_booleans
#    end
#
#    def remove_from_flags(*flags)
#      flags.each { |name| @act_with_booleans.remove_accessor(name) }
#    end
#
#    def clear_flags_at_save(*flags)
#      @act_with_booleans.clear_at_save(*flags)
#    end
#
#    private
#
#    def init(origin, range)
#      unless @act_with_booleans
#        @act_with_booleans ||= ActWithBooleans::Admin.new self
#        @act_with_booleans.add_mask_et_all origin
#      end
#
#      unless range.nil?
#        validate_range_value range.begin
#        validate_range_value range.end
#      end
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
#end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require "act_with_booleans/version"
#require "act_with_booleans/utils"
#require "act_with_booleans/define"
#require "act_with_booleans/admin"
#require "act_with_booleans/flags"
#require "act_with_booleans/clear"
#require "act_with_booleans/print"
