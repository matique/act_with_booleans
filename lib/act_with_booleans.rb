# frozen_string_literal: true

# Principles:
#  POLA
#  KISS
#  YAGNI
#  POLS
#  DEI
#  TDD is great
#  TGCB
#  TIOLI
#  PORO

module ActWithBooleans
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_reader :act_with_booleans

    def add_to_booleans(*booleans, origin: nil, **hash)
      origin = origin&.to_sym
      init(origin)

      booleans.each { |name| act_with_booleans.add_flag(name, nil) }
      hash.each { |name, pos| act_with_booleans.add_flag(name, pos) }
    end

    def booleans_mask(*booleans)
      booleans.inject(0) { |memo, bool|
        memo | 1 << act_with_booleans.position(bool)
      }
    end

    private

    def init(origin)
      unless act_with_booleans
        @act_with_booleans = ActWithBooleans::Admin.new self
        origin ||= :booleans
        act_with_booleans.origin = origin
        act_with_booleans.add_mask_et_all origin
        origin = nil
      end
      raise "ActWithBooleans: origin already defined" if origin
    end
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require "act_with_booleans/version"
require "act_with_booleans/utils"
require "act_with_booleans/define"
require "act_with_booleans/admin"
require "act_with_booleans/booleans"
require "act_with_booleans/print"
