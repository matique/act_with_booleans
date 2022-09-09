# frozen_string_literal: true

class ActWithBooleans::Admin
  Location = Struct.new(:model, :origin, :position)

  attr_reader :locations

  def location(name)
    location = @locations[name]
    return location if location

    parent = model.superclass.act_with_booleans
    return parent.location(name) if parent

    raise "unknown boolean '#{model}##{name}'"
  end

  def position(name)
    location(name).position
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
