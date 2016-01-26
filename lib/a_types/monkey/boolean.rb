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


# Adds #to_bool and #to_bool!
class Numeric
  # Interprets this Numeric to a boolean value.
  #
  # @return [true, false] true if this is > 0, false otherwise.
  def to_bool
    self > 0 ? true : false
  end
  alias_method :to_b, :to_bool
  alias_method :to_bool!, :to_bool
  alias_method :to_b!, :to_bool
end


# Adds #to_bool and #to_bool!
class String
  # Converts this String to a boolean value.
  # - Single characters are converted to _true_ if they are part of the set
  #     ['y', 'Y', '1']
  #
  # - Multiple characters are converted to _true_ if they are part of the set
  #     ['yes', 'Yes', 'YES', 'true', 'True', 'TRUE']
  #
  # - In any other case, the result will be false.
  #
  # @return [true, false] depending on the content.
  def to_bool
    %w(y Y 1 yes Yes YES true True TRUE).include?(self)
  end
  alias_method :to_b, :to_bool


  # Converts this String to a boolean value.
  # - Single characters are converted to true if they are part of the set
  #     ['y', 'Y', '1']
  #
  # - Single characters are converted to _false_ if they are part of the set
  #     ['n', 'N', '0', '']
  #
  # - Multiple characters are converted to _true_ if they are part of the set
  #     ['yes', 'Yes', 'YES', 'true', 'True', 'TRUE']
  #
  # - Multiple characters are converted to _false_ if they are part of the set
  #     ['no', 'No', 'NO', 'false', 'False', 'FALSE']
  #
  # - In any other case, an ArgumentError will be raised.
  #
  # @return [true, false] depending on the content.
  # @raise [ArgumentError] if this String is no real boolean value.
  def to_bool!
    return true if  %w(y Y 1 yes Yes YES true True TRUE).include?(self)

    negative = ['n', 'N', '0', 'no', 'No', 'NO', 'false', 'False', 'FALSE', '']
    return false if negative.include?(self)

    fail ArgumentError, "#{self} can't be interpreted as boolean!"
  end
  alias_method :to_b!, :to_bool!
end


# Adds #to_bool and #to_bool!
class Object
  # @return [true] respecting the Ruby way.
  def to_bool
    true
  end
  alias_method :to_b, :to_bool
  alias_method :to_bool!, :to_bool
  alias_method :to_b!, :to_bool
end

# Adds #to_bool and #to_bool!
class NilClass
  include Boolean

  # @return [false] respecting the Ruby way.
  def to_bool
    false
  end

  alias_method :to_b, :to_bool
  alias_method :to_bool!, :to_bool
  alias_method :to_b!, :to_bool
end


# Adds #to_bool and #to_bool!
class TrueClass
  include Boolean

  # @return [true] respecting the Ruby way.
  def to_bool
    self
  end
  alias_method :to_b, :to_bool
  alias_method :to_bool!, :to_bool
  alias_method :to_b!, :to_bool
end


# Adds #to_bool and #to_bool!
class FalseClass
  include Boolean

  # @return [false] respecting the Ruby way.
  def to_bool
    self
  end

  alias_method :to_b, :to_bool
  alias_method :to_bool!, :to_bool
  alias_method :to_b!, :to_bool
end

