# frozen_string_literal: true

class ActWithBooleans::Admin
  def add_accessors(accessor, origin, mask)
    unless model.method_defined?(:act_with_booleans)
      model.class_eval %(
        def act_with_booleans
          #{model}.act_with_booleans
        end
      ), __FILE__, __LINE__ - 4
    end

    model.class_eval %(
      def #{accessor}
        #{accessor}?
      end

      def #{accessor}?
        !( self.#{origin}.to_i & #{mask} ).zero?
      end

      def #{accessor}=(value)
        booleans = self.#{origin}.to_i

        result = self.act_with_booleans.to_boolean(value)
        if result
          booleans |= #{mask}
        else
          booleans &= ~#{mask}
        end
        self.#{origin} = booleans

        result
      end
    ), __FILE__, __LINE__ - 31
  end

  def remove_accessor(accessor)
    my_undef model, accessor, "#{accessor}?", "#{accessor}="
  end
end
