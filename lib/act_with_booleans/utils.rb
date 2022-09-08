# frozen_string_literal: true

class ActWithBooleans::Admin
  def add_flag(name, pos)
p 22222222222222
p name, pos
    accessor = name.to_sym
p accessor
    validate_accessor accessor, "#{accessor}?", "#{accessor}="
p 23

    pos = check_pos(model, pos)
p 24
    msg = "Invalid position <#{pos}>"
p 25
    raise(ArgumentError, msg) unless pos.is_a?(Integer)
    raise(ArgumentError, msg) unless pos >= 0
    loc = Location.new(model, origin, pos)
    add_to_locations accessor, loc

    validate_position(range, pos)

    mask = mask(accessor)
    add_accessors(accessor, origin, mask)
  end

  def add_mask_et_all(origin)
    model.class_eval %(
      def flags_mask(*names)
        self.class.act_with_booleans.mask(*names)
      end

      def flags_any?(*names)
        mask = self.class.act_with_booleans.mask(*names)
        !( self.#{origin} & mask ).zero?
      end

      def flags_all?(*names)
        mask = self.class.act_with_booleans.mask(*names)
        ( self.#{origin} & mask ) == mask
      end

      def flags_none?(*names)
        mask = self.class.act_with_booleans.mask(*names)
        ( self.#{origin} & mask ).zero?
      end
    ), __FILE__, __LINE__ - 19
  end

  def reset
    names = @locations.keys.sort
    names.each { |name|
      remove_accessor name
    }
    reset_model model
  end

  def validate_position(range, position)
    return if range.nil?
    return if range.cover?(position)

    msg = "Position #{position} out of range #{range}"
    raise RangeError, msg
  end

  private

  def validate_accessor(*names)
    names.each { |acc|
      raise "redefining #{acc} rejected" if model.method_defined?(acc)
    }
  end

  def my_undef(*names)
    names.each { |name|
      model.class_eval %(
        begin
          undef #{name}
        rescue
        end
      ), __FILE__, __LINE__ - 5
    }
  end
end
