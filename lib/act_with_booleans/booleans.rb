# frozen_string_literal: true

class ActWithBooleans::Admin
  Location = Struct.new(:model, :origin, :position)

  attr_reader :locations

  def mask(*booleans)
    return 0 if booleans.empty?

    res = mask2d(*booleans)
    raise "Mixing origins fails: #{booleans}" unless res.length == 1

    res.values.first
  end

  def mask2d(*booleans)
    res = {}
    booleans.each { |bool|
      model, orig, pos = location(bool).values
      idx = "#{model}##{orig}"
      mask = res[idx] || 0
      res[idx] = mask | (1 << pos)
    }
    res
  end

  def location(name)
    location = @locations[name]
    return location if location

    parent = model.superclass.act_with_booleans
    return parent.location(name) if parent

    raise "unknown boolean '#{model}##{name}'"
  end

  private

  def position(name)
    location(name).position
  end

  def add_to_locations(flag, location)
    who = "<#{flag}: #{location.origin}@#{location.position}>"
    raise "name already used #{who}" if @locations.key?(flag)
    bool = @locations.has_value?(location)
    raise "position already used #{who}" if bool
    @locations[flag] = location
  end

  def check_pos(model, pos)
    return pos if pos

    max_position = -1
    @locations.each { |name, location|
      model2, orig2, pos2 = location.values
      next unless model == model2 && origin == orig2

      max_position = pos2 if pos2 > max_position
    }

    max_position + 1
  end
end