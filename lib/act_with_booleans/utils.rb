# frozen_string_literal: true

class ActWithBooleans::Admin
  def add_flag(name, pos)
    accessor = name.to_sym
    validate_accessor accessor, "#{accessor}?", "#{accessor}="

    pos = check_pos(model, pos)
    msg = "Invalid position <#{pos}>"
    raise(ArgumentError, msg) unless pos.is_a?(Integer)
    raise(ArgumentError, msg) unless pos >= 0
    loc = Location.new(model, origin, pos)
    add_to_locations accessor, loc

    mask = mask(accessor)
    add_accessors(accessor, origin, mask)
  end

  def add_mask_et_all(origin)
    model.class_eval %(
      def booleans_mask(*names)
        self.class.act_with_booleans.mask(*names)
      end

      def booleans_any?(*names)
        mask = booleans_mask(*names)
        !( self.#{origin} & mask ).zero?
      end

      def booleans_all?(*names)
        mask = booleans_mask(*names)
        ( self.#{origin} & mask ) == mask
      end

      def booleans_none?(*names)
        mask = booleans_mask(*names)
        ( self.#{origin} & mask ).zero?
      end
    ), __FILE__, __LINE__ - 19
  end

  def reset
    names = @locations.keys.sort
    names.each { |name|
      remove_accessors name
    }
    reset_model model
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
