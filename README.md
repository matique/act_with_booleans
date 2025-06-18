# ActWithBooleans

[![Gem Version](https://img.shields.io/gem/v/act_with_booleans?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/act_with_booleans)
[![Downloads](https://img.shields.io/gem/dt/act_with_booleans?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/act_with_booleans)
[![GitHub Build](https://img.shields.io/github/actions/workflow/status/matique/act_with_booleans/rake.yml?logo=github)](https://github.com/matique/act_with_booleans/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-168AFE.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-168AFE.svg)](http://choosealicense.com/licenses/mit/)

A Ruby gem handling booleans placed in an integer.

Defines setters and getters to access the booleans.

## Installation

As usual:
```ruby
# Gemfile
gem "act_with_booleans"
```
and run "bundle install".

## Examples

### Simple Example

```ruby
#require "act_with_booleans"

class Foo
  include ActWithBooleans
  attr_accessor :booleans

  add_to_booleans :x, :y
end

foo = Foo.new
foo.x    # --> false
foo.x = true
foo.x    # --> true
foo.x?   # --> true
Foo.booleans_mask(:x, :y) # 3 (0x03)
```

## Example Using Position

```ruby
class Foo
  add_to_booleans z: 10
end

Foo.booleans_mask(:z) # 1024 (0x400 or 2 ** 10)
```

### Additional Functions

```ruby
foo.x = true
foo.y = false
foo.booleans_any?(:x, :y)  # true
foo.booleans_all?(:x, :y)  # false
foo.booleans_none?(:x, :y) # false
```

### Using a Non Default Origin

```ruby
#require "act_with_booleans"

class Foo
  include ActWithBooleans
  attr_accessor :flags

  add_to_booleans :x, :y, origin: :flags
end

foo = Foo.new
foo.x    # --> false
```
### Internals

```ruby
Foo.act_with_booleans.size # 11
Foo.act_with_booleans.position(:y) # 1
Foo.act_with_booleans.to_s
```

## Rails

ActWithBooleans is PORO,
i.e. it can and, usually, will be used in Rails.

The "origin" (default :booleans) is an integer containing the booleans.

Ruby supports pretty large integers,
but your database has limitations.
Therefore, it is strongly recommended to validate accordingly
the "origin" in the model.

## Testing

As "Best Practice" a test coverage of 100% has been achieved
(and should be kept).

GitHub workflow enable tests for several configurations.
Please, feel free to inspect the corresponding file.

## Links

Further reading:

- [gem bitmask_attributes](https://github.com/joelmoss/bitmask_attributes)
- [gem bitfields](https://github.com/grosser/bitfields)
- [gem active_flag](https://github.com/kenn/active_flag)
- [gem has-bit-field](https://github.com/pjb3/has-bit-field)
- [gem bitfield_attribute](https://github.com/gzigzigzeo/bitfield_attribute)
- [gem bitwise](https://github.com/kenn/bitwise)


## Miscellaneous

Copyright (c) 2023-2025 Dittmar Krall (www.matiq.com),
released under the [MIT license](https://opensource.org/licenses/MIT).
