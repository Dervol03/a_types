# This file adds the #to_bool method to numerous default classes of ruby,
# providing a more convenient of boolean handling to them. There are special
# cases for descendents of String and Numeric, all other objects will simply
# return their truthy-value according to Ruby's interpretation of truth.


# Adds #to_bool and #to_bool!
class Numeric
  # Interprets this Numeric to a boolean value.
  #
  # @return [true, false] true if this is > 0, false otherwise.
  def to_bool
    self > 0 ? true : false
  end
  alias to_b to_bool
  alias to_bool! to_bool
  alias to_b! to_bool
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
  alias to_b to_bool


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
    return true if %w(y Y 1 yes Yes YES true True TRUE).include?(self)

    negative = ['n', 'N', '0', 'no', 'No', 'NO', 'false', 'False', 'FALSE', '']
    return false if negative.include?(self)

    fail ArgumentError, "#{self} can't be interpreted as boolean!"
  end
  alias to_b! to_bool!
end


# Adds #to_bool and #to_bool!
class Object
  # @return [true] respecting the Ruby way.
  def to_bool
    !nil?
  end
  alias to_b to_bool
  alias to_bool! to_bool
  alias to_b! to_bool
end



# Adds #to_bool and #to_bool!
class TrueClass
  # @return [true] respecting the Ruby way.
  def to_bool
    self
  end
  alias to_b to_bool
  alias to_bool! to_bool
  alias to_b! to_bool
end


# Adds #to_bool and #to_bool!
class FalseClass
  # @return [false] respecting the Ruby way.
  def to_bool
    self
  end

  alias to_b to_bool
  alias to_bool! to_bool
  alias to_b! to_bool
end


# Adds a Boolean cast method.
module Kernel
  # Casts the given object to its boolean representation.
  #
  # @param [Object] obj_to_cast to be cast.
  # @return [true, false] depending on the object.
  def Boolean(obj_to_cast)
    obj_to_cast.to_bool
  end
end
