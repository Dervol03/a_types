# Empty module to be included in the TrueClass and FalseClass to permit a check
# for whether a variable is a Boolean
#
# @example
#   bool = true
#   bool.is_a?(Boolean)     #=> true
#
#   no_bool = 'nope'
#   no_bool.is_a?(Boolean)  #=> false
module Boolean
end


# Adds #to_bool
class Numeric
  # Interprets this Numeric to a boolean value.
  #
  # @return [true, false] true if this is > 0, false otherwise.
  def to_bool
    self > 0 ? true : false
  end
  alias_method :to_b, :to_bool
end


# Adds the possibility to type cast any object to either TrueClass or
# FalseClass. It will look for special strings and values. If none of them are
# found, it will fall back to Ruby's default boolean behavior.
#
# - for Numeric:
#     - values > 0  are cast to true
#     - values < 1  are cast to false
# module Kernel
#   def Boolean(object)
#     object.to_bool
#   end
# end


