# Provides convenience methods to convert objects into number representations
# . Most prominently #to_num method.

# Numeric additions.
class Object
  # @return nil
  def to_num
    nil
  end
end # Object


# Numeric Additions.
class Numeric
  # Returns itself.
  #
  # @return [Numeric] itself.
  def to_num
    self
  end
end # Numeric


# Numeric Additions.
class String
  # Will convert any string with a valid number into the correct type (Fixnum
  # or Float). If this String does not contain a valid number, nil will be
  # returned.
  #
  # @return [Numeric, nil] depending on the value of this String.
  def to_num
    if self =~ /^-?\d+$/
      to_i
    elsif self =~ /^-?\d+[,.]\d+$/
      sub(',', '.').to_f
    end
  end
end # String


# Numeric Additions.
class TrueClass
  # @return 1
  def to_num
    1
  end
end


# Numeric Additions.
class FalseClass
  # @return -1
  def to_num
    -1
  end
end


# Numeric Additions.
class Array
  # Tries to convert the joined result of this Array into a number. If this
  # fails, nil is returned.
  #
  # @return [Numeric, nil] depending on whether joining returns a valid
  #                   number String.
  #
  # @example
  #   [1,2,3,4].to_num            # => 1234
  #   [1, '1.5', 6, 7].to_num     # => 11.567
  #   [1, 'a', 2].to_num          # => nil
  def to_num
    join.to_num
  end
end # Array
