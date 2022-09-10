# frozen_string_literal: true

class ActWithBooleans::Admin
  Location = Struct.new(:model, :origin, :position)

  attr_reader :locations

  def position(name)
    @locations[name].position
  end

  private

  def add_to_locations(flag, location)
    who = "<#{flag}: #{location.origin}@#{location.position}>"
    raise "name already used #{who}" if @locations.key?(flag)
    bool = @locations.has_value?(location)
    raise "position already used #{who}" if bool
    @locations[flag] = location
  end

  def check_pos(pos)
    pos ||= @size

    raise "Position already in use" if pos < @size
    @size = pos + 1
    pos
  end
end
