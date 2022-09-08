# frozen_string_literal: true

class ActWithBooleans::Admin
  attr_reader

  def initialize(model)
    @locations = {}
    @model = model
    @boolean_hash = {}
    [true, "true", 1, "1"].each { |x| @boolean_hash[x] = true }
    [false, "false", 0, "0"].each { |x| @boolean_hash[x] = false }
  end

  def reset_model(model)
    initialize model
  end

  def to_boolean(value)
    res = @boolean_hash[value]
    return res unless res.nil?

    raise "invalid boolean <#{value}>"
  end
end
